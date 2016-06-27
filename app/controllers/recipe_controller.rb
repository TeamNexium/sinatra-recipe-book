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
  	else
  		redirect '/login'
  	end
  end

  get '/recipes/new' do
  	if logged_in?
  		erb :'recipes/new'
  	else 
  		redirect '/login'
  	end
  end

  post '/recipes' do
  	@recipe = Recipe.new(name: params["recipe_name"], ingredients: params["ingredients"], instructions: params["instructions"])
  	if @recipe.save
  		redirect '/recipes'
  	else
  		redirect "recipes/new"
  	end
  end
end