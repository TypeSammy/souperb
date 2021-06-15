get '/signup' do
  erb :"/user/new", locals: { error: "" }
end

post '/signup' do
  username = params[:username]
  email = params[:email]
  pw = params[:password]
  existing_user_check = username_check(username)
 
  if existing_user_check == nil
    user_sign_up(username, email, pw)
    redirect "/login"
  elsif username == existing_user_check
    erb :"user/new", locals: { error: "Username taken" }
  end

end