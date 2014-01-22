module Api
  module V1
    class TrackerEventsController < ApplicationController

      def index
        project = Project.find(params[:project_id])
        tracker_events = project.tracker_events 
        render json: tracker_events, status: 200
      end

      def create
        tracker_project = TrackerProject.find_by(:pt_project_id => params[:tracker_event][:pt_project_id])
        tracker_project.tracker_events.create(tracker_event_params)
        render nothing: true, status: 201
      end

      private

      def tracker_event_params
        params.require(:tracker_event).permit(:story_url, :message, :kind, :user_name, :story_id)
      end
    end

  end
end
