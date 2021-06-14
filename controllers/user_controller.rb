get '/signup' do
  erb :"/user/new"
end

post '/signup' do
  username = params[:username]
  email = params[:email]
  pw = params[:password]

  user_sign_up(username, email, pw)
  redirect "/login"
end