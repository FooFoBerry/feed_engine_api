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

  describe "POST /projects/:project_id/tracker_projects" do

    describe "with Valid Data" do
      before :each do
        @project = FactoryGirl.create(:project)
        @tracker_project_params = FactoryGirl.build(:tracker_project).as_json
      end

      it "responds with 201" do
        post "/api/v1/projects/#{@project.id}/tracker_projects",
                                            { :tracker_project => @tracker_project_params },
                                            { "HTTP_ACCEPT" => "application/json" }

        expect(response.status).to eq 201
      end

      it "tracker project count increases by one" do 
       expect {
        post "/api/v1/projects/#{@project.id}/tracker_projects",
                                            { :tracker_project => @tracker_project_params },
                                            { "HTTP_ACCEPT" => "application/json" }
              }.to change{ @project.tracker_projects.count }.by(1)
        body = JSON.parse(response.body)
        body["pt_project_id"].should eq 123456 
      end
    end

    describe "with invalid data" do 
      before :each do 
        @project = FactoryGirl.create(:project)
        @tracker_project_params = FactoryGirl.build(:tracker_project, :pt_project_id => nil).as_json
      end

      it "responds with error messages and 418 status" do 
         expect { 
          post "/api/v1/projects/#{@project.id}/tracker_projects",
                                            { :tracker_project => @tracker_project_params },
                                            { "HTTP_ACCEPT" => "application/json" } 
         }.to change{ TrackerProject.count }.by(0)
        expect(response.status).to eq 418

        body = JSON.parse(response.body)
        body["errors"].should include("pt_project_id")
        #expect(response.status).to eq 500
      end
    end
  end
end
