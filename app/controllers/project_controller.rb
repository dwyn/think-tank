require 'rack-flash'

class ProjectsController < ApplicationController
  use Rack::Flash

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
    binding.pry
    if params[:description] != ""
      @project = Project.create(:content =>params[:description])
      @project.user = current_user
      @project.section_id = params[:section_id]
      @project.save
      redirect "/projects/#{@project.id}"
    end
  end

  get '/projects/:id' do
    if logged_in?
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

  post '/projectss/:id/edit' do
    @project = Project.find_by_id(params[:id])
    if @project.user == current_user && params[:content] != ""
      @project.content = params[:content]
      @project.save
      redirect "/projects/#{@project.id}"
    else
      redirect "/projects/#{@project.id}/edit"
    end
  end

  delete '/projects/:id/delete' do
    @project = Project.find(params[:id])
    if @project.user == current_user
      @project.destroy
      redirect "/"
    else
      redirect "/projects/#{@project.id}"
    end
  end
end
