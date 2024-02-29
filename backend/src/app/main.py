import os
from typing import List

from mindee import Client
from fastapi import FastAPI
from fastapi.routing import APIRoute
from fastapi.middleware import Middleware
from fastapi.middleware.cors import CORSMiddleware

from .models import (
    OCRRequest,
    ChatBotRequest,
    ChatBotResponse,
    RecipeHomeResponse,
    RecipeHomeRequest,
    ExpiryRequest,
    ExpiryResponse,
    RecipeRequest
)
from .ocr import receipt_ocr
from .chat_gpt import OpenAIChatBot
from .recipe_db import RecipeDB
from .expiry_db import ExpiryDB

mindee_api_key = os.getenv("MINDEE_API_KEY")
chat_get_key = os.getenv("OPENAI_API_KEY")
recipes_db_file = "foodcom_normal.json"
expiry_db_file = "expiry.csv"


mindee_client = Client(mindee_api_key)
recipes_db = RecipeDB(filename=recipes_db_file)
expiry_db = ExpiryDB(filename=expiry_db_file)
chat_gpt_bot = OpenAIChatBot(api_key=chat_get_key, recipes_db=recipes_db)


async def root():
    return {"result": "Hello Bhukad Saand"}


async def get_ocr(request: OCRRequest) -> List[str]:
    response = await receipt_ocr(
        mindee_client=mindee_client,
        base64string=request.input_string,
        filename=request.filename,
    )
    return response


async def get_expiry_from_ingredients(
    request: ExpiryRequest,
) -> List[ExpiryResponse]:
    response = await expiry_db.get_expiry_from_ingredients(
        ingredients=request.ingredients
    )
    return response


async def ask_chat_gpt(request: ChatBotRequest) -> ChatBotResponse:
    if request.current_recipe == "GENERAL":
        chat_gpt_bot.set_pre_chat_state(
            request.inventory, request.recipe_history, request.calorie
        )
        response = await chat_gpt_bot.get_response_from_agent(
            question=request.input_string
        )
        return ChatBotResponse(result=response.strip())
    else:
        recipe_text = recipes_db.get_recipe(request.current_recipe)
        response = await chat_gpt_bot.get_response_from_chatgpt(
            current_context=recipe_text,
            user_text=request.input_string,
        )
        return ChatBotResponse(result=response.strip())


async def get_recipes(request: RecipeHomeRequest) -> List[RecipeHomeResponse]:
    if request.ingredients:
        response = recipes_db.get_recipe_from_ingredients(
            ingredients=request.ingredients
        )
    else:
        response = await recipes_db.get_recipes()
    return response


async def get_recipe(request: RecipeRequest) -> str:
    return recipes_db.get_recipe(request.title)



routes = [
    APIRoute("/", endpoint=root, methods=["GET"]),
    APIRoute("/ocr", endpoint=get_ocr, methods=["POST"]),
    APIRoute("/ask_chat_gpt", endpoint=ask_chat_gpt, methods=["POST"]),
    APIRoute("/all_recipes", endpoint=get_recipes, methods=["POST"]),
    APIRoute("/expiry", endpoint=get_expiry_from_ingredients, methods=["POST"]),
    APIRoute("/get_recipe", endpoint=get_recipe, methods=["POST"]),
]

middleware = Middleware(CORSMiddleware)

app = FastAPI(routes=routes, middleware=[middleware])
