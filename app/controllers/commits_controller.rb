class CommitsController < ApplicationController

  def index
    commits = Commit.where(:project_id => params[:project_id])
    render json: commits
  end

  def show
    commit = Commit.find(params[:id])
    render json: commit
  end

end
