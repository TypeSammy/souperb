require "sinatra"
require "sinatra/reloader" if development?
require "pry" if development?
require "pg"

get '/' do
 redirect "/login"
end

enable :sessions

require_relative "db/db"
require_relative "models/user"
require_relative "models/recipe"
require_relative "helpers/sessions_helper"
require_relative "helpers/recipe_helper"
require_relative "controllers/user_controller"
require_relative "controllers/recipe_controller"
require_relative "controllers/session_controller"