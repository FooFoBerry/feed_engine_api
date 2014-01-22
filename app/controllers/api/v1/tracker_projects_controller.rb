module Api
  module V1
    class TrackerProjectsController < ApplicationController

      def index
        project = Project.find(params[:project_id])
        tracker_projects = project.tracker_projects
        render json: tracker_projects, :status => 200
      end

      def create
        project = Project.find(params[:project_id])
        tracker_project = project.tracker_projects.new(tracker_project_params)
        if tracker_project.save
          render json: tracker_project, status:  201
        else
          render json: tracker_project_errors(tracker_project), status: 418
        end
      end

      private

      def tracker_project_params
        params.require(:tracker_project).permit(:pt_project_id)
      end

      def tracker_project_errors(project)
        messages = project.errors.messages
        errors_hash = { "errors" => messages }
      end

    end
  end
end
