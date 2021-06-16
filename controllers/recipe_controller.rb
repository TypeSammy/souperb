get '/souperb' do
  if user_logged_in?()
      new_recipes = new_recipes(session[:user_id])
    erb :"/recipe/index", locals: { new_recipe: new_recipes }
  else
    redirect "/login"
  end
end

get '/create' do
  if user_logged_in?()   
    erb :"/recipe/new"
  else
    redirect "/login"
  end
end

post '/create' do
  if user_logged_in?() 
    user_id = session[:user_id]
    recipe_name = params[:recipe_name]
    serving_size = params[:serving_size]
    prep_time = params[:prep_time]
    cook_time = params[:cook_time]
    image_url = params[:image_url]
    source = params[:source]
    ingredients = params[:ingredients]
    method = params[:method]
    calories = params[:calories] == "" ? 0 : params[:calories]
    total_fat = params[:total_fat] == "" ? 0 : params[:total_fat]
    saturated_fat = params[:saturated_fat] == "" ? 0 : params[:saturated_fat]
    cholesterol = params[:cholesterol] == "" ? 0 : params[:cholesterol]
    sodium = params[:sodium] == "" ? 0 : params[:sodium]
    total_carb = params[:total_carb] == "" ? 0 : params[:total_carb]
    dietary_fibre = params[:dietary_fibre] == "" ? 0 : params[:dietary_fibre]
    sugars = params[:sugars] == "" ? 0 : params[:sugars]
    protein = params[:protein] == "" ? 0 : params[:protein]

    create_recipe(user_id, recipe_name, serving_size, prep_time, cook_time, image_url, source, ingredients, method, calories, total_fat, saturated_fat, cholesterol, sodium, total_carb, dietary_fibre, sugars, protein)

    # get recipe id function

    recipe_information = find_recipe("recipe_name", recipe_name)
    recipe_id = recipe_information[0]["id"]

    breakfast = false
    lunch = false
    dinner = false
    dessert = false
    favourite = false

    if params[:breakfast] == "on"
      breakfast = true
    end
    if params[:lunch] == "on"
      lunch = true
    end
    if params[:dinner] == "on"
      dinner = true
    end
    if params[:dessert] == "on"
      dessert = true
    end
    if params[:favourite] == "on"
      favourite = true
    end

    create_recipe_categories(user_id, recipe_id, breakfast, lunch, dinner, dessert, favourite)

    redirect "/display/#{recipe_id}"
  else
    redirect "/login"
  end
end


get '/display/:id' do |id|
  if user_logged_in?()   
    data = find_recipe("id", id)
    ingredients = line_break(data[0]["ingredients"])
    method = line_break(data[0]["method"])
    erb :"/recipe/show", locals: { recipe: data, ingredients: ingredients, method: method }
  else
    redirect "/login"
  end
end

get '/display/:id/edit' do |id|
  if user_logged_in?()   
    categories = recipe_categories(id)
    data = find_recipe("id", id)
    erb :"recipe/edit", locals: { recipe: data[0], categories: categories[0] }
  else
    redirect "/login"
  end
end

put '/display/:id/edit' do |id|
  id = params[:id]
  recipe_name = params[:recipe_name]
  serving_size = params[:serving_size]
  prep_time = params[:prep_time]
  cook_time = params[:cook_time]
  image_url = params[:image_url]
  source = params[:source]
  ingredients = params[:ingredients]
  method = params[:method]
  calories = params[:calories] == "" ? 0 : params[:calories]
  total_fat = params[:total_fat] == "" ? 0 : params[:total_fat]
  saturated_fat = params[:saturated_fat] == "" ? 0 : params[:saturated_fat]
  cholesterol = params[:cholesterol] == "" ? 0 : params[:cholesterol]
  sodium = params[:sodium] == "" ? 0 : params[:sodium]
  total_carb = params[:total_carb] == "" ? 0 : params[:total_carb]
  dietary_fibre = params[:dietary_fibre] == "" ? 0 : params[:dietary_fibre]
  sugars = params[:sugars] == "" ? 0 : params[:sugars]
  protein = params[:protein] == "" ? 0 : params[:protein]

  update_recipe(id, recipe_name, serving_size, prep_time, cook_time, image_url, source, ingredients, method, calories, total_fat, saturated_fat, cholesterol, sodium, total_carb, dietary_fibre, sugars, protein)

  breakfast = false
  lunch = false
  dinner = false
  dessert = false
  favourite = false

  if params[:breakfast] == "on"
    breakfast = true
  end
  if params[:lunch] == "on"
    lunch = true
  end
  if params[:dinner] == "on"
    dinner = true
  end
  if params[:dessert] == "on"
    dessert = true
  end
  if params[:favourite] == "on"
    favourite = true
  end

  update_categories(id, breakfast, lunch, dinner, dessert, favourite)

  redirect "/display/#{id}"
end

post '/category' do
  selected_category = params[:category].downcase
  redirect "/category/#{selected_category}"
end

get '/category/:selected_category' do |selected_category|
  if user_logged_in?()  
    if selected_category == "all"
      display_category = display_all(session[:user_id])
    elsif selected_category != "all"
      display_category = recipe_by_category(selected_category)
    end
    erb :"/recipe/category", locals: { category: display_category, selected_category: selected_category } 
  else
    redirect "/login"
  end
end

delete "/display/:id/edit" do |id|
  delete_recipe("recipes", "id", id)
  delete_recipe("user_recipe_categories", "recipe_id", id)
  redirect "/"
end