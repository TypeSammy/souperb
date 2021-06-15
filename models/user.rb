require "bcrypt"

def user_sign_up(username, email, pw)
  password_digest = BCrypt::Password.create(pw)
  sql_query = "INSERT INTO users(username, email, password_digest) VALUES($1, $2, $3);"
  params = [username, email, password_digest]
  run_sql(sql_query, params)
end

def find_user(column_name, value)
  sql_query = "SELECT * FROM users WHERE #{column_name} = $1;"
  params = [value]
  results = run_sql(sql_query, params)

  if results.to_a.length > 0
    results[0]
  else
    nil
  end
end

def username_check(username_input)
  username_in_db = find_user("username", username_input)
  if username_in_db != nil
    result = username_in_db["username"]
  else
    result = nil
  end
  result
end