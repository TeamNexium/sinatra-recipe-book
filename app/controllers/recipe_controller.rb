require './config/environment'
require './app/helpers/helper_methods'

class RecipeController < Sinatra::Base
	include HelperMethods

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/recipes' do
  	if logged_in?
  	erb :'recipes/index'
  end
  end

  get '/recipes/new' do
  	erb :new
  end
end