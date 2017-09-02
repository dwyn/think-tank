require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Flash
  end

  get "/" do
    @random_app_idea = []
    @random_app_idea = Project.all
    # binding.pry
    erb :welcome
  end

end
