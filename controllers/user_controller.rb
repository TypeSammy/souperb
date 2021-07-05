get "/signup" do
  erb :"/user/new", locals: { error: "" }
end

post "/signup" do
  username = params[:username]
  email = params[:email]
  pw = params[:password]
  db_username = db_username_check(username)

  # validators
  valid_email_check = valid_email_check(email)
  valid_password_check = valid_pw_check(pw)
  valid_user_check = valid_username_check(username, db_username)

  if valid_email_check && valid_password_check && valid_user_check
    user_sign_up(username, email, pw)
    user = find_user("username", username)
    session[:user_id] = user["id"]
    redirect "/"
  elsif valid_email_check == false
    erb :"user/new", locals: { error: "Invalid Email" }
  elsif valid_password_check == false
    erb :"user/new", locals: { error: "Password must be 8 characters long, include one uppercase letter and one number" }
  elsif valid_user_check == false
    erb :"user/new", locals: { error: "Username taken" }
  end
end