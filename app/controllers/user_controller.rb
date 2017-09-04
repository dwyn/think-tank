require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController
#RENDER COMING FROM THE WELCOME PAGE
  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/projects/index'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:id] = @user.id
      redirect to "/users/home"
    end
  end

#USERS HOME PAGE REDIRECTED FROM SIGNUP PAGE
  get '/users/home' do
    puts "Hello world"
    if logged_in?
      @user = current_user unless current_user == nil
      erb :'users/home'
    else
      redirect "/login"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/home"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

end
