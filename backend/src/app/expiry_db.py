import csv
from typing import List

from .models import ExpiryResponse

import rapidfuzz


class ExpiryDB:
    def __init__(self, filename: str):
        with open(filename, mode="r") as f:
            self.expiry_db = list(csv.DictReader(f))

    async def get_expiry_from_ingredients(
        self, ingredients: List[str]
    ) -> List[ExpiryResponse]:
        ingredients_as_str = " ".join(ingredients)
        return [
            ExpiryResponse(
                ingredient_name=expiry.get("ingredients", "water"),
                ttl=expiry.get("refrigerated", "10 days"),
            )
            for expiry in self.expiry_db
            if (
                rapidfuzz.fuzz.partial_ratio(
                    ingredients_as_str,
                    " ".join([expiry.get("ingredients")]),
                )
                > 80
            )
        ]
