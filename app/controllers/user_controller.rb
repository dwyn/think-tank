require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController

  get '/home' do
    @user = current_user
    erb :'/users/home'
  end
#RENDER FROM THE WELCOME PAGE
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
      @user = User.create(:name => params[:username], :email => params[:email], :password => params[:password])

      session[:id] = @user.id
      redirect to "/home"
    end
  end

  post '/login' do
    user = User.find_by(:name => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/home"
    else
      redirect to '/signup'
    end
  end

#USE SLUG TO MAKE ROUTE RESTFUL
  get '/users/:slug' do
    @user = current_user
    @user_projects = current_user.projects.all
    erb :"/projects/user_projects"
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
