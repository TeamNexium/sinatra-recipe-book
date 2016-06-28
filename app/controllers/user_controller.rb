require './config/environment'
require './app/helpers/helper_methods'

class UserController < Sinatra::Base
	include HelperMethods

  	configure do
    	set :views, 'app/views'
    	enable :sessions
    	set :public_folder, 'public'
    	set :session_secret, "password_security"
	end

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		@current_user = current_user
		erb :'users/show'
	end
end