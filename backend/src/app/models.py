from typing import List
from pydantic import BaseModel


class OCRRequest(BaseModel):
    input_string: str
    filename: str


class OCR(BaseModel):
    item_name: str
    # total_amount: float
    # confidence: float


class ChatBotRequest(BaseModel):
    current_recipe: str
    input_string: str
    inventory: List[str] | None
    recipe_history: List[str] | None
    calorie: str | None


class ChatBotResponse(BaseModel):
    result: str


class RecipeHomeResponse(BaseModel):
    recipe_name: str
    prep_time: str
    calories: str
    url: str


class ExpiryResponse(BaseModel):
    ingredient_name: str
    ttl: float


class RecipeHomeRequest(BaseModel):
    ingredients: List[str]


class ExpiryRequest(BaseModel):
    ingredients: List[str]


class Nutrition(BaseModel):
    calories: str


class Recipe(BaseModel):
    ingredients: List[str]
    steps: List[str]
    name: str
    nutrition: Nutrition | None
    readyIn: str

class RecipeRequest(BaseModel):
    title: str
