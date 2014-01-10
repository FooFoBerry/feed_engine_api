class ReposController < ApplicationController
  before_action :get_project, only: [:index, :show]

  def index
    repos = @project.repos
    render json: repos
  end

  def show
    repo = @project.repos.find(params[:id])
    render json: repo
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end

end
