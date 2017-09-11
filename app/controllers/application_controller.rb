require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  # use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash, :sweep => true
    set :session_secret, "secret"
  end

  get "/" do
    if !logged_in?
      @random_app_idea = Project.all.sample
      erb :welcome
    else
      @user = current_user
      # binding.pry
      # @user_name = @user.username.find_by_slug(params[:slug])
      @user_name = @user.username
      params[:name] = @user_name
      erb :"/users/home"
    end
  end

  helpers do
     def logged_in?
       !!session[:user_id]
     end

     def current_user
       User.find(session[:user_id])
     end

   end
end
