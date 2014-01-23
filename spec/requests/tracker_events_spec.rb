require 'spec_helper'

describe "Tracker Events API" do
  describe "GET /projects/:project_id/tracker_events" do
    it "returns the project's tracker events" do
      project = FactoryGirl.create :project, name: "Tracking Puffy"
      tracker_project = FactoryGirl.create :tracker_project, project_id: project.id
      tracker_event = FactoryGirl.create :tracker_event, tracker_project_id: tracker_project.id,
                                                         story_id: 100
      tracker_event = FactoryGirl.create :tracker_event, story_id: 200

      get "api/v1/projects/#{project.id}/tracker_events"

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      tracker_events = body.map { |te| te["story_id"] }

      expect(tracker_events).to match_array([100])
    end
  end

  describe "POST /tracker_events" do 
    before :each do 
      @tracker_project = FactoryGirl.create :tracker_project, pt_project_id: 654320
      @params = {
        :story_url => "http://github.com",
        :message   => "started story",
        :kind      => "update story",
        :user_name => "THE watts",
        :story_id  => 45678,
        :pt_project_id => 654320
      }
    end

    it "creates a tracker event associated with the correct tracker project" do  
      expect { post "/api/v1/tracker_events", { tracker_event: @params }, 
                              { "HTTP_ACCEPT" => "application/json" } 
      }.to change{ @tracker_project.tracker_events.count }.by(1)
      expect(response.status).to eq 201 
    end 

    it "does not create with invalid params" do 
      params = @params.merge(:story_id => nil)
      expect { post "/api/v1/tracker_events", { tracker_event: params }, 
                              { "HTTP_ACCEPT" => "application/json" } 
      }.to change{ @tracker_project.tracker_events.count }.by(0)
      expect(response.status).to eq 418
    end
  end
end
