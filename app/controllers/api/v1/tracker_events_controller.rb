module Api
  module V1
    class TrackerEventsController < ApplicationController

      def index
        project = Project.find(params[:project_id])
        tracker_events = project.tracker_events 
        render json: tracker_events, status: 200
      end
    end
  end
end
