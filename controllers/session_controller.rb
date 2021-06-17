get "/login" do
  erb :"/user/index", locals: { error: "" }
end

post "/login" do
  username = params[:username]
  pw = params[:password]
  user = find_user("username", username)

  if user == nil
    erb :"user/index", locals: { error: "Username does not exist" }
  else
    bcrypt_pw = BCrypt::Password.new(user["password_digest"])
    if user && bcrypt_pw == pw
      session[:user_id] = user["id"]
      redirect "/souperb"
    else
      erb :"user/index", locals: { error: "Incorrect password" }
    end
  end
end

delete "/signout" do
  session[:user_id] = nil
  redirect "/"
end