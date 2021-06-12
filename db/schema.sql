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
serving_size NUMERIC,
prep_time NUMERIC,
cook_time NUMERIC,
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