class ReposController < ApplicationController
  before_action :get_project, only: [:index, :show, :create]

  def index
    repos = @project.repos
    render json: repos
  end

  def show
    repo = @project.repos.find(params[:id])
    render json: repo
  end

  def create
    repo = @project.repos.new(params[:repo])
    if repo.save
      render json: repo, :status => 201
    else
      render json: repo_errors(repo), :status => 422
    end
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end

  def repo_errors(repo)
    messages = repo.errors.messages
    errors_hash = { "errors" => messages }
  end

end
