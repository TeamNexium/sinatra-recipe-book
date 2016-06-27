require './config/environment'

class RecipeController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/recipes' do
  	erb :'recipes/index'
  end
end