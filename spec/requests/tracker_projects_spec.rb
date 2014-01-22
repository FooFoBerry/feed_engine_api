require 'spec_helper'

describe "Tracker Projects API" do
  describe "GET /projects/:project_id/tracker_projects" do
    # :TODO: VCR
    it "returns all the project's tracker projects" do
      project = FactoryGirl.create :project
      tracker_project = FactoryGirl.create :tracker_project, project_id: project.id

      get "/api/v1/projects/#{project.id}/tracker_projects", {}, { "HTTP_ACCEPT" => "application/json" }


      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      tracker_projects = body.map { |tracker_project| tracker_project["id"] }

      expect(tracker_projects).to match_array([tracker_project.id])
    end
  end
end
