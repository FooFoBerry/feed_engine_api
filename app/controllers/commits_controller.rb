class CommitsController < ApplicationController

  def index
    commits = Commit.where(:project_id => params[:project_id])
    render json: commits
  end

  def show
    commit = Commit.find(params[:id])
    render json: commit
  end

  def create
    project = Project.find(params[:project_id])
    commit = project.commits.new(params[:commit])
    if commit.save
      render :nothing => true, :status => 201
    else
      render :nothing => true, :status => 422
    end
  end

end
