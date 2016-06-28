require './config/environment'
require './app/helpers/helper_methods'


class RecipeController < Sinatra::Base
	include HelperMethods

 	configure do
    	set :views, 'app/views'
    	enable :sessions
      set :public_folder, 'public'
    	set :session_secret, "password_security"
 	end

	get '/recipes' do
  		if logged_in?
  			@user = current_user
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
  		@recipe.user = current_user
  		if @recipe.save
  			redirect '/recipes'
  		else
  			redirect "/recipes/new"
  		end
  	end

  	get '/recipes/:id/edit' do
  		if logged_in?
  			@recipe = Recipe.find_by(id: params[:id])
  			erb :'recipes/edit'
  		else
  			redirect '/login'
  		end
  	end

  	post '/recipes/:id' do
  		@recipe = Recipe.find_by(id: params[:id])
  		@recipe.update(name: params["recipe_name"], ingredients: params["ingredients"], instructions: params["instructions"])
  		if @recipe.save
  			redirect "/recipes/#{params[:id]}"
  		else
  			redirect "/recipes/#{params[:id]}/edit"
  		end
  	end

  	get '/recipes/:id' do
  		if logged_in?
  			@recipe = Recipe.find_by(id: params[:id])
  			@user = current_user
  			erb :'recipes/show'
  		else
  			redirect '/login'
  		end
  	end

    delete '/recipes/:id/delete' do
      @recipe = Recipe.find_by(id: params[:id])
      if logged_in? && @recipe.user == current_user
        @recipe.destroy
        session[:message] = "You successfully deleted your recipe"
        redirect '/recipes'
      else
        redirect '/recipes/#{@recipe.id}'
      end
    end

end