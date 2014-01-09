class ProjectsController < ApplicationController

  def index
    user_id = params[:user_id]
    render json: Project.where(:user_id => user_id)
  end

  def show
    render json: Project.find(params[:id])
  end

  def create
    project = Project.new(params[:project])
    if project.save
      render json: project, :status => 201
    else
      render :nothing => true, :status => 422
    end
  end

end
