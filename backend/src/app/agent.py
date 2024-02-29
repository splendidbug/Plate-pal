from langchain import OpenAI,LLMChain, PromptTemplate
from langchain.memory import ConversationBufferWindowMemory


template = """PlatePal is a large language model.

PlatePal is designed to be able to assist Human in following a recipe such as providing explanations for the provided Reciepe. As a language model, PlatePal is able to generate human-like text based on the input it receives, allowing it to engage in natural-sounding conversations and provide responses that are coherent and relevant to the Recipe.

{history}
Recipe: {recipe}
Human: {human_input}
PlatePal:"""

prompt = PromptTemplate(
    input_variables=["history", "recipe", "human_input"], 
    template=template
)

chatgpt_chain = None
def create(key):
    global chatgpt_chain
    print('KEYYYYYYY', key)
    chatgpt_chain = LLMChain(
        llm=OpenAI(temperature=0, openai_api_key=key), 
        prompt=prompt, 
        verbose=True, 
        memory=ConversationBufferWindowMemory(k=2, input_key="human_input"),
    )

def ask_agent(human_input, recipe):
    return chatgpt_chain.predict(human_input=human_input, recipe=recipe)

     