require 'spec_helper'

describe "Projects API" do
  describe "GET /projects" do
    it "returns all the projects" do
      FactoryGirl.create :project, name: "Meecrosoft", user_id: 123
      FactoryGirl.create :project, name: "Weendows", user_id: 123
      FactoryGirl.create :project, name: "Arch", user_id: 321

      get "/projects?user_id=123", {}, { "HTTP_ACCEPT" => "application/json" }

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

  describe "POST /projects" do
    describe "with valid params" do
      before :each do
        @project_params = FactoryGirl.build(:project).as_json
      end

      it "responds with 201" do
        post "/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 201
      end

      it "creates a new project given valid data" do
        expect {
          post "/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        }.to change{Project.count}.by(1)
      end
    end

    describe "with invalid param" do
      before :each do
        @project_params = FactoryGirl.build(:project, :name => "").as_json
      end

      it "responds with 422" do
        post "/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 422
      end

      it "creates a new project given valid data" do
        expect {
          post "/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        }.to change{Project.count}.by(0)
      end
    end
  end
end
