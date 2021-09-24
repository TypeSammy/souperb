CREATE TABLE users (
id SERIAL PRIMARY KEY,
username TEXT,
email TEXT,
password_digest TEXT
);

CREATE TABLE recipes (
id SERIAL PRIMARY KEY,
user_id INT,
recipe_name TEXT,
serving_size TEXT,
prep_time TEXT,
cook_time TEXT,
image_url TEXT,
source TEXT,
ingredients TEXT,
method TEXT,
calories NUMERIC,
total_fat NUMERIC,
saturated_fat NUMERIC,
cholesterol NUMERIC,
sodium NUMERIC,
total_carb NUMERIC,
dietary_fibre NUMERIC,
sugars NUMERIC,
protein NUMERIC
);

CREATE TABLE user_recipe_categories (
  id SERIAL PRIMARY KEY,
  user_id INT,
  recipe_id INT,
  breakfast BOOLEAN,
  lunch BOOLEAN,
  dinner BOOLEAN,
  dessert BOOLEAN,
  favourite BOOLEAN
);

-- to display ALL recipes from specific user:
SELECT * FROM recipes WHERE user_id = 1;

-- display recipes where breakfast is true and user id is 1
SELECT user_recipe_categories.breakfast FROM user_recipe_categories INNER JOIN recipes ON user_recipe_categories.user_id = recipes.user_id;

-- Shows recipe ID, name and image URL from specific user ID
SELECT recipes.id, recipe_name, image_url FROM recipes LEFT JOIN user_recipe_categories ON user_recipe_categories.recipe_id = recipes.id WHERE recipes.user_id = 1;

-- Shows recipe ID, name and img_url from specific user ID AND category
SELECT recipes.id, recipe_name, image_url FROM recipes LEFT JOIN user_recipe_categories ON user_recipe_categories.recipe_id = recipes.id WHERE recipes.user_id = 1 AND user_recipe_categories.breakfast = true;


SELECT category.category_name FROM category INNER JOIN flashcards ON category.user_id = fkashcards.user_id
-- Display all flashcards 


SELECT flashcards.id, question, hint, answer FROM flashcards LEFT JOIN category ON category.flashcard_id = flashcards.id WHERE flashcards.user_id = $1 AND category.${category_name} = $1