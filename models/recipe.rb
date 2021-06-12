def create_recipe(user_id, recipe_name, serving_size, prep_time, cook_time, image_url, source, ingredients, method, calories, total_fat, saturated_fat, cholesterol, sodium, total_carb, dietary_fibre, sugars, protein)
  sql_query = "INSERT INTO recipes(user_id, recipe_name, serving_size, prep_time, cook_time, image_url, source, ingredients, method, calories, total_fat, saturated_fat, cholesterol, sodium, total_carb, dietary_fibre, sugars, protein) VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18)"
  params = [user_id, recipe_name, serving_size, prep_time, cook_time, image_url, source, ingredients, method, calories, total_fat, saturated_fat, cholesterol, sodium, total_carb, dietary_fibre, sugars, protein]
  run_sql(sql_query, params)
end

def find_recipe(column_name, value)
  sql_query = "SELECT * FROM recipes WHERE #{column_name} = $1"
  params = [value]
  run_sql(sql_query, params)
end

def recipe_categories(user_id, recipe_id, breakfast, lunch, dinner, dessert, favourite)
  sql_query = "INSERT INTO user_recipe_categories(user_id, recipe_id, breakfast, lunch, dinner, dessert, favourite) VALUES($1, $2, $3, $4, $5, $6, $7)"
  params = [user_id, recipe_id, breakfast, lunch, dinner, dessert, favourite]
  run_sql(sql_query, params)
end