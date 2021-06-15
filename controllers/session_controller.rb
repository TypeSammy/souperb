get '/login' do
  erb :"/user/index", locals: { error: "" }
end

post "/login" do
  username = params[:username]
  pw = params[:password]

  user = find_user("username", username)
  bcrypt_pw = BCrypt::Password.new(user["password_digest"])

  if user && bcrypt_pw == pw
    session[:user_id] = user["id"]
    redirect "/souperb"
  else
    erb :"user/index", locals: { error: "Incorrect username or password" }
  end
end

delete "/signout" do
  session[:user_id] = nil
  redirect "/"
end