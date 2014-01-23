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
        tracker_event = tracker_project.tracker_events.new(tracker_event_params)
        if tracker_event.save
          push(tracker_event)
          render json: tracker_event, status: 201
        else
          render json: tracker_event_errors(tracker_event), status: 418
        end
      end

      private

      def tracker_event_params
        params.require(:tracker_event).permit(:story_url,
                                              :message,
                                              :kind,
                                              :user_name,
                                              :story_id,
                                              :change_type,
                                              :story_title,
                                              :user_initials)
      end

      def tracker_event_errors(tracker)
        messages = tracker.errors.messages
        errors_hash = {"errors" => messages}
      end

      def push(tracker_event)
        data       = TrackerEventSerializer.new tracker_event
        project_id = tracker_event.tracker_project.project.id
        Pusher["project_#{project_id}"].trigger("tracker_notification",
          :data => data.as_json)
      end
    end
  end
end
