require 'rack-flash'

class ProjectsController < ApplicationController
  use Rack::Flash, :sweep => true

  get '/projects' do
    @projects = Project.all

    erb :'/projects/index'
  end

  get '/projects/new' do
    if logged_in?
      @sections = Section.all
      erb :'/projects/create_project'
    else
      redirect '/login'
    end
  end

  post '/projects/new' do
    if params[:description] != ""
      @project = Project.create(:description =>params[:description], :project_name => params[:project_name], :link => params[:link])
      @project.user = current_user
      @project.section_id = params[:section_id]
      @project.save

      flash[:message] = "Thanks for your app idea, #{current_user.username.capitalize}!"
      redirect "/projects/#{@project.id}"
    end
  end

  get '/projects/:id' do
    if logged_in? && current_user == @project.user_id
      @project = Project.find_by_id(params[:id])
      erb :'/projects/show_projects'
    else
      redirect '/login'
    end
  end

  get '/projects/:id/edit' do
    if logged_in?
      @project = Project.find_by_id(params[:id])
      erb :'projects/edit_project'
    else
      redirect '/login'
    end
  end

  post '/projects/:id/edit' do
    # binding.pry
    @project = Project.find_by_id(params[:id])
    # binding.pry
    if @project.user_id == current_user && params[:content] != ""
      binding.pry
      @project.project_name = params[:project_name]
      @project.description = params[:description]
      @project.link = params[:link]
      @project.save
      flash[:message] = "Project successfully updated!"
      redirect "/projects/#{@project.id}"
    else
      flash[:message] = "You didnt change anything. Try again."
      redirect "/projects/#{@project.id}/edit"
    end
  end

  delete '/projects/:id/delete' do
    @project = Project.find(params[:id])
    if @project.user == current_user
      @project.destroy
      flash[:message] = "Project successfully obliterated." #{<a href="/projects/new"> Would you like to reate another?</a>?}" can I add a hyperlink to my project?
      redirect "/"
    else
      redirect "/projects/#{@project.id}"
    end
  end
end
