def user_logged_in?
  session[:user_id] == nil ? false : true
end

def current_user
  if user_logged_in?()
    find_user("id", session[:user_id])
  else
    nil
  end
end