require 'spec_helper'

describe "Projects API" do
  describe "GET /projects" do
    it "returns all the projects" do
      FactoryGirl.create :project, name: "Meecrosoft"
      FactoryGirl.create :project, name: "Weendows"

      get "/projects", {}, { "HTTP_ACCEPT" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      project_titles = body.map { |p| p["name"] }

      expect(project_titles).to match_array(["Meecrosoft",
                                             "Weendows"])
    end
  end

  describe "GET /projects/:id" do
    it "returns the right project" do
      FactoryGirl.create :project
      project = FactoryGirl.create :project, name: "Ben"

      get "/projects/#{project.id}", {}, { "HTTP_ACCEPT" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      project_title = body["name"]

      expect(project_title).to eq("Ben")
    end
  end
end
