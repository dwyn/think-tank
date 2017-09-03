require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  # use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "thinktank_secret"
  end

  get "/" do
    @random_app_idea = Project.all.sample

    erb :welcome
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
