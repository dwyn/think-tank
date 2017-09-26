require 'rack-flash'

class ProjectsController < ApplicationController
  use Rack::Flash, :sweep => true

  get '/projects' do
    @users = User.all
    @projects = Project.all
    @sections = Section.all
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
      @project = Project.create(:description =>params[:description], :name => params[:project_name])
      @project.user_id = current_user.id
      @project.section_id = params[:section_id]
      @project.save

      flash[:message] = "Thanks for your app idea, #{current_user.name.capitalize}!"
      redirect "/projects/#{@project.id}"
    end
  end

  get '/projects/:id' do
    if logged_in? && current_user
      @users = User.all
      @sections = Section.all
      @project = Project.find_by_id(params[:id])
      erb :'/projects/show_projects'
    else
      redirect '/login'
    end
  end

  get '/projects/:id/edit' do
    if @project.user_id == current_user.id && params[:content] != ""
      @project = Project.find_by_id(params[:id])
      erb :'projects/edit_project'
    else
      redirect '/login'
    end
  end

  post '/projects/:id/edit' do
    # binding.pry
    @project = Project.find_by_id(params[:id])
    if @project.user_id == current_user.id && params[:content] != ""
      @project.name = params[:project_name]
      @project.description = params[:description]
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
    if @project.user_id == current_user.id
      @project.destroy
      flash[:message] = "Project successfully obliterated." #{<a href="/projects/new"> Would you like to reate another?</a>?}" can I add a hyperlink to my project?
      redirect "/"
    else
      redirect "/projects/#{@project.id}"
    end
  end
end
