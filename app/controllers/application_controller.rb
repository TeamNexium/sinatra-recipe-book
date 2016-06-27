require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
  	erb :homepage
  end

  get '/login' do
  	if logged_in?
  		redirect '/recipes'
  	else
  		erb :login
  	end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
  		
  	else
  	 	session[:error] = "Something went wrong"
  	 	redirect to '/login'
  	end
  end

 end