# import base64

# with open("test.jpeg", "rb") as image_file:
#     encoded_string = base64.b64encode(image_file.read())

# print(encoded_string.decode("utf-8"))

import json
import rapidfuzz

with open("recipe_db.json", "r") as outfile:
    a = json.load(outfile)

i = [
    "melons cantaloupe",
    "creole seasoning",
    "cauliflower",
    "sauce oyster",
    "goose",
    "paprika",
    "lemon juice",
    "sugars",
]

for j in a:
    some = " ".join([ing.get("text") for ing in j.get("ingredients")])
    if rapidfuzz.fuzz.partial_ratio(" ".join(i), some) > 70:
        print(j.get("title"), j.get("ingredients"))

# with open("src/app/food_db.json", "w") as outfile:
#     json.dump(a, outfile, indent=4)
