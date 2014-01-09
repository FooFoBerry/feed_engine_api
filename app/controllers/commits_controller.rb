class CommitsController < ApplicationController

  def index
    commits = Commit.where(:project_id => params[:project_id])
    render json: commits
  end

end
