import json
from typing import List

import rapidfuzz

from .models import RecipeHomeResponse


class RecipeDB:
    def __init__(self, filename: str):
        with open(filename, mode="r") as f:
            self.recipe_db = json.load(f)

    async def get_recipes(self) -> List[RecipeHomeResponse]:
        return [
            RecipeHomeResponse(
                recipe_name=recipe.get("title"),
                prep_time=recipe.get("readyIn", "10 mins"),
                calories=recipe.get("nutrition", {}).get("calories", "100"),
                url=recipe.get("url", "https://www.youtube.com/c/codeblazex"),
            )
            for recipe in self.recipe_db
        ]

    def get_recipe_from_ingredients(
        self, ingredients: List[str]
    ) -> List[RecipeHomeResponse]:
        ingredients_as_str = " ".join(ingredients)
        return [
            RecipeHomeResponse(
                recipe_name=recipe.get("title"),
                prep_time=recipe.get("readyIn", "10 mins"),
                calories=recipe.get("nutrition", {}).get("calories", "100"),
                url=recipe.get("url", "https://www.youtube.com/c/codeblazex"),
            )
            for recipe in self.recipe_db
            if (
                rapidfuzz.fuzz.partial_ratio(
                    ingredients_as_str.lower(),
                    " ".join(
                        [
                            ingredient.get("text").lower()
                            for ingredient in recipe.get("ingredients")
                        ]
                    ),
                )
                > 80
            )
        ]

    def get_recipe(self, title) -> str:
        for recipe in self.recipe_db:
            if rapidfuzz.fuzz.partial_ratio(title, recipe.get("title")) > 85:
                return (
                    "Title: "
                    + recipe["title"]
                    + "\n"
                    + "Calories:"
                    + recipe["nutrition"]["calories"]
                    + "\n"
                    + "Ingredients:\n"
                    + "\n".join(
                        list(map(lambda x: "-" + x["text"], recipe["ingredients"]))
                    )
                    + "\nSteps:"
                    + "\n".join(
                        list(map(lambda x: "-" + x["text"], recipe["instructions"]))
                    )
                )

        return "No matching recipe found."
