require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/user/create_user'
    else
      redirect to '/project/index'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:id] = @user.id
      redirect to "/projects"
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/projects"
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

  get '/projects' do
    "Hello World"

    erb :'/project/index'
  end


end
