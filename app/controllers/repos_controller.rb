class ReposController < ApplicationController

  def index
    project = Project.find(params[:project_id])
    repos = project.repos
    render json: repos
  end

end
