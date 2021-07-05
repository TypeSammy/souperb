require "bcrypt"

def valid_pw_check(pw)
  pw_length = pw.length
  pw_incl_upcase = /[[:upper:]]/.match(pw) == nil ? 0 : 1 #found this online!!
  pw_incl_num = pw.count("0-9")
  if pw_length >= 8 && pw_incl_upcase == 1 && pw_incl_num >= 1
    true
  else
    false
  end
end

def user_sign_up(username, email, pw)
  password_digest = BCrypt::Password.create(pw)
  sql_query = "INSERT INTO users(username, email, password_digest) VALUES($1, $2, $3);"
  params = [username, email, password_digest]
  run_sql(sql_query, params)
end

def find_user(column_name, value)
  sql_query = "SELECT * FROM users WHERE #{column_name} = $1 LIMIT 1;"
  params = [value]
  results = run_sql(sql_query, params)

  if results.to_a.length > 0
    results[0]
  else
    nil
  end
end

def db_username_check(username_input)
  username_in_db = find_user("username", username_input)
  if username_in_db != nil
    result = username_in_db["username"]
  else
    result = nil
  end
  result
end

def valid_username_check(username_input, db_username)
  if username_input == db_username
    false
  else
    true
  end
end

def valid_email_check(email_input)
  one_at_sign = email_input.count "@"
  include_decimal = email_input.count "."
  split_at_sign = email_input.split "@"
  include_decial_after_at_sign = split_at_sign.last.count "."
  decimal_index = split_at_sign.last.index"."

  if one_at_sign != 1
    false
  elsif include_decimal == 0
    false
  elsif split_at_sign.first.length == 0
    false
  elsif include_decial_after_at_sign < 1
    false
  elsif decimal_index == 0
    false
  elsif split_at_sign[1].nil?
    false
  elsif split_at_sign[1][-1] == "."
    false
  else
    true
  end
end
