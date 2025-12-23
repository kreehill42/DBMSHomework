# File: reehill_PE12.sql
# Name: Korben Reehill
# ISTE230 - Intro to DBs & Data Modeling
# Professor Hardy
# PE12 - Multi-Table Join and Subqueries
# Date: 11/21/2025

USE recipes;


# Task 1 -- Getting Mom's Recipes
SELECT name
FROM recipe
WHERE source = "Mom";

# Task 2 -- Find Recipes w/ <800 Calories
SELECT recipe.name
FROM recipe JOIN nutrition
ON recipe.recipeID = nutrition.recipeID
WHERE (nutrition.quantity < 800 AND nutrition.unit = "calories");

# Task 3 -- Beef Parmesan Ingredients
SELECT ingredient.name, ingredientList.quantity
FROM (recipe JOIN ingredientList
    ON recipe.recipeID = ingredientList.recipeID)
JOIN ingredient
ON ingredientList.ingredientID = ingredient.ingredientID
WHERE recipe.name LIKE '%Beef Parmesan%';

# Task 4 -- Vegetarian (or pescatarian) recipes using subqueries
SELECT name
FROM recipe
WHERE recipeID NOT IN (
    SELECT recipe.recipeID
    FROM (recipe JOIN ingredientList
    ON recipe.recipeID = ingredientList.recipeID)
    JOIN ingredient
    ON ingredientList.ingredientID = ingredient.ingredientID
    WHERE(
        ingredient.type = 'beef' OR
        ingredient.type = 'pork' OR
        ingredient.type = 'chicken' OR
        ingredient.type = 'lamb'
    )
);


# Task 5 -- Fish recipes w/ <700 calories

SELECT DISTINCT recipe.name
FROM(
        (recipe JOIN nutrition
            ON recipe.recipeID = nutrition.recipeID
        )
    JOIN ingredientList
    ON nutrition.recipeID = ingredientList.recipeID
    )
    JOIN ingredient
    ON ingredientList.ingredientID = ingredient.ingredientID
WHERE (
    nutrition.quantity < 700 AND
    nutrition.unit = 'calories' AND
    ingredient.type = 'fish'
);




