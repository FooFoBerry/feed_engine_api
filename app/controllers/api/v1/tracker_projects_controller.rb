module Api
  module V1
    class TrackerProjectsController < ApplicationController

      def index
        project = Project.find(params[:project_id])
        tracker_projects = project.tracker_projects
        render json: tracker_projects, :status => 200
      end

    end
  end
end
