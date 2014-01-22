require 'spec_helper'
describe "Tracker Events API" do
  describe "GET /projects/:project_id/tracker_events" do
    it "returns the project's tracker events" do
      pending
      project = FactoryGirl.create :project, name: "Tracking Puffy"
      tracker_event = FactoryGirl.create :tracker_event, project_id: project.id,
                                                         story_id: 100
      tracker_event = FactoryGirl.create :tracker_event, story_id: 200

      get "api/v1/projects/#{project.id}/tracker_events"

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      tracker_events = body.map { |te| te["story_id"] }

      expect(tracker_events).to match_array(["100"])
    end
  end
end
