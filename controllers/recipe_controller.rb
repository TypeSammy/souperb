get '/souperb' do
  # data = select_category()
  # erb :"/recipe/index", locals: { category: data }
end

get '/create' do
  # data = select_category()
  erb :"/recipe/new"
end

post '/create' do
  user_id = 1
  recipe_name = params[:recipe_name]
  serving_size = params[:serving_size]
  prep_time = params[:prep_time]
  categories_selected = params[:categories] #do something with this, return array
  cook_time = params[:cook_time]
  image_url = params[:image_url]
  source = params[:source]
  ingredients = params[:ingredients]
  method = params[:method]
  calories = params[:calories]
  total_fat = params[:total_fat]
  saturated_fat = params[:saturated_fat]
  cholesterol = params[:cholesterol]
  sodium = params[:sodium]
  total_carb = params[:total_carb]
  dietary_fibre = params[:dietary_fibre]
  sugars = params[:sugars]
  protein = params[:protein]

  create_recipe(user_id, recipe_name, serving_size, prep_time, cook_time, image_url, source, ingredients, method, calories, total_fat, saturated_fat, cholesterol, sodium, total_carb, dietary_fibre, sugars, protein)

  # get recipe id function

  recipe_information = find_recipe("recipe_name", recipe_name)
  recipe_id = recipe_information[0]["id"]

  breakfast = false
  lunch = false
  dinner = false
  dessert = false
  favourite = false

  if categories_selected != nil
    categories_selected.each do |category|
      if category == "breakfast"
        breakfast = true
      elsif category == "lunch"
        lunch = true
      elsif category == "dinner"
        dinner = true
      elsif category == "dessert"
        dessert = true
      elsif category == "favourite"
        favourite = true
      end
    end
  end

  recipe_categories(user_id, recipe_id, breakfast, lunch, dinner, dessert, favourite)

  redirect "/display/#{recipe_id}"
end

get '/display/:id' do |id|
  data = find_recipe("id", id)
  erb :"/recipe/show", locals: { recipe: data }
end

get '/display/:id/edit' do |id|
  data = find_recipe("id", id)
  erb :"recipe/edit", locals: { recipe: data }
end

post '/display/:id/edit' do
  redirect "/#{recipe_id}/#{recipe_name}"
end

put '/display/:id/edit' do |id|
  id = params[:id]
  recipe_name = params[:recipe_name]
  serving_size = params[:serving_size]
  prep_time = params[:prep_time]
  # NEED TO DO CATEGORIES
  cook_time = params[:cook_time]
  image_url = params[:image_url]
  source = params[:source]
  ingredients = params[:ingredients]
  method = params[:method]
  calories = params[:calories]
  total_fat = params[:total_fat]
  saturated_fat = params[:saturated_fat]
  cholesterol = params[:cholesterol]
  sodium = params[:sodium]
  total_carb = params[:total_carb]
  dietary_fibre = params[:dietary_fibre]
  sugars = params[:sugars]
  protein = params[:protein]

  update_recipe(id, recipe_name, serving_size, prep_time, cook_time, image_url, source, ingredients, method, calories, total_fat, saturated_fat, cholesterol, sodium, total_carb, dietary_fibre, sugars, protein)

  redirect "/display/#{id}"
end