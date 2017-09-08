require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController

  # get '/home' do
  #   @user = current_user
  #   # erb :'/users/user_home'
  # end
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
      redirect to "/users/user_home"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/user_home"
    else
      redirect to '/signup'
    end
  end

#USE SLUG TO MAKE ROUTE RESTFUL
  get '/:name/projects' do
    @user = current_user
    params[:name] = @user.username
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
