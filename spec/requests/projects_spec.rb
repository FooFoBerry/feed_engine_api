require 'spec_helper'

describe "Projects API" do
  describe "GET /projects" do
    it "returns all the projects" do
      FactoryGirl.create :project, name: "Meecrosoft", user_id: 123
      FactoryGirl.create :project, name: "Weendows", user_id: 123
      FactoryGirl.create :project, name: "Arch", user_id: 321

      get "/api/v1/projects?user_id=123", {}, { "HTTP_ACCEPT" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      project_titles = body.map { |p| p["name"] }

      expect(project_titles).to match_array(["Meecrosoft",
                                             "Weendows"])
    end

    it "returns all the projects with repos" do
      project = FactoryGirl.create :project, name: "Meecrosoft", user_id: 123
      project.repos.create(github_url: "foofoberry/costner")
      project.repos.create(github_url: "rails/rails")

      get "/api/v1/projects?user_id=123", {}, { "HTTP_ACCEPT" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      repos = body[0]["repos"]

      expect(repos.first["github_url"]).to eq "foofoberry/costner"
      expect(repos.last["github_url"]).to eq "rails/rails"
    end
  end

  describe "GET /projects/:id" do
    it "returns the right project" do
      FactoryGirl.create :project
      project = FactoryGirl.create :project, name: "Ben"

      get "/api/v1/projects/#{project.id}", {}, { "HTTP_ACCEPT" => "application/json" }

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
        post "/api/v1/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 201
      end

      it "creates a new project given valid data" do
        expect {
          post "/api/v1/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        }.to change{Project.count}.by(1)

        body = JSON.parse(response.body)
        body["id"].should be_kind_of(Fixnum)
        body["name"].should eq("FooFoo")
        body["user_id"].should eq(123)
      end
    end

    describe "with invalid param" do
      before :each do
        @project_params = FactoryGirl.build(:project, :name => "").as_json
      end

      it "responds with 422" do
        post "/api/v1/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 422
      end

      it "creates a new project given valid data" do
        expect {
          post "/api/v1/projects", { :project => @project_params }, { "HTTP_ACCEPT" => "application/json" }
        }.to change{Project.count}.by(0)

        body = JSON.parse(response.body)
        body["errors"].should include("name")
      end
    end
  end
end
