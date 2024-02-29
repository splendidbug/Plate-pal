from typing import Optional

from langchain import OpenAI, LLMChain, PromptTemplate
from langchain.memory import ConversationBufferWindowMemory

from langchain.agents import load_tools
from langchain.agents import initialize_agent, Tool

import requests
class OpenAIChatBot:
    def __init__(self, api_key, recipes_db):
        template = """PlatePal is a large language model.
        
            PlatePal is designed to be able to assist Human in following a recipe such as providing explanations for the provided Reciepe. As a language model, PlatePal is able to generate human-like text based on the input it receives, allowing it to engage in natural-sounding conversations and provide responses that are coherent and relevant to the Recipe.

            {history}
            Recipe: {recipe}
            Human: {human_input}
            PlatePal:
        """

        self.recipes_db = recipes_db

        self.llm = OpenAI(temperature=0, openai_api_key=api_key)
        self.chatgpt_chain = LLMChain(
            llm=self.llm,
            prompt=PromptTemplate(
                input_variables=["history", "recipe", "human_input"], template=template
            ),
            verbose=True,
            memory=ConversationBufferWindowMemory(k=2, input_key="human_input"),
        )

        self.recipe_info = Tool(
            name = "Recipe",
            func = self.get_recipe_info,
            description = "Use this to fetch information about details of a specific recipe by it's title."
        )

        self.user_calorie = Tool(
            name = "CalorieLimit",
            func = self.get_user_calorie_limit,
            description = "Fetch user's max calorie limit. Use this in combination with UserRecipeHistory to make sure suggested recipe's calories combined when added to user's history does not exceed user's calorie limit"
        )

        self.user_history = Tool(
            name = "UserRecipeHistory",
            func = self.get_user_history,
            description = "Fetch user's recipe history.  Use this in combination with CalorieLimit to make sure suggested recipe's calories combined when added to user's history does not exceed user's calorie limit"
        )

        self.recipe_from_ingredient = Tool(
            name = "RecipesFromIngredients",
            func = self.get_recipe_from_ingredient,
            description = "Fetch information about which recipes the user can make."
        )


        self.agent = initialize_agent(
            load_tools(["llm-math"], llm=self.llm) + [self.recipe_info, self.recipe_from_ingredient, self.user_history, self.user_calorie],
            self.llm, agent="zero-shot-react-description",
            verbose=True,
        )

    def get_recipe_info(self, title):
        out = self.recipes_db.get_recipe(title)
        print(out)
        return out

    def get_recipe_from_ingredient(self, _):
        res = self.recipes_db.get_recipe_from_ingredients(
            ingredients=self.ingredients,
        )

        out = 'The following are the recipes the user can make given their current ingredients list given as {"Title","Calories","Preparation Time"}\n'
        lines = 0
        for e in res:
            out += '{"' + e.recipe_name + '","' + e.calories + '","' + e.prep_time + '"}\n'
            lines += 1
            if lines > 20:
                break

        print(out)
        return out

    def set_pre_chat_state(self, ingredients, history, calorie):
        self.ingredients = ingredients
        self.history = history
        self.calorie = calorie

    def get_user_history(self, _):
        out = 'The following is the user\'s recipe history by recipe title:\n'+'\n'.join(self.history)
        print(out)
        return out
        
    def get_user_calorie_limit(self, _):
        out = 'The user\'s max calorie limit is ' + str(self.calorie) + '.'
        print(out)
        return out

    # def reset_bot(self):
    #     self.messages = [
    #         {
    #             "role": "system",
    #             "content": "You are FoodGPT. You will be provided with recipe, ingredients and nutrition information. You are to assist with any questions in following the recipe",
    #         },
    #     ]
    #     self.first_query = True

    async def get_response_from_chatgpt(
        self, current_context: str, user_text: str
    ) -> str:
        return self.chatgpt_chain.predict(human_input=user_text, recipe=current_context)

    async def get_response_from_agent(
        self, question: str
    ) -> str:
        return self.agent.run(question)
