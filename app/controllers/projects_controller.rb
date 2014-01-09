class ProjectsController < ApplicationController

  def index
    render json: Project.all
  end

  def show
    render json: Project.find(params[:id])
  end

  def create
    project = Project.new(params[:project])
    if project.save
      render :nothing => true, :status => 201
    else
      render :nothing => true, :status => 422
    end
  end

end
