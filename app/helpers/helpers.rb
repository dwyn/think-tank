class Helpers < ApplicationController
  helpers do
    def self.logged_in?
      !!session[:id]
      # binding.pry
    end

    def self.current_user
      User.find(session[:id])
    end
  end
end
