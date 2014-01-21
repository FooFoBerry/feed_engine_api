require 'spec_helper'

describe "Repos API" do
  describe "GET /projects/:project_id/repos" do
    use_vcr_cassette

    it "returns all the project's repos" do
      repo = FactoryGirl.create :repo, github_url: "http://gh.com/abc"
      repo2 = FactoryGirl.create :repo, github_url: "http://gh.com/123", gh_repo_id: 12345
      repo3 = FactoryGirl.create :repo, github_url: "http://gh.com/def", gh_repo_id: 23456
      project = FactoryGirl.create :project, name: "Biggy"
      project.repos << repo
      project.repos << repo2

      get "/api/v1/projects/#{project.id}/repos"

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      repos = body.map { |r| r["github_url"] }

      expect(repos).to match_array(["http://gh.com/abc",
                                    "http://gh.com/123"])
    end
  end

  describe "GET /projects/:project_id/repos/:id" do
    use_vcr_cassette

    it "returns the right repo" do
      repo = FactoryGirl.create :repo, github_url: "http://gh.com/1"
      project = FactoryGirl.create :project, name: "Biggy"
      project.repos << repo

      get "/api/v1/projects/#{project.id}/repos/#{repo.id}"
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      repo = body["github_url"]

      expect(repo).to eq("http://gh.com/1")
    end
  end

  describe "POST /projects/:project_id/repos" do
    describe "with valid params" do
      use_vcr_cassette

      before :each do
        @project = FactoryGirl.create(:project)
        @repo_params = FactoryGirl.build(:repo).as_json
      end

      it "responds with 201" do
        post "/api/v1/projects/#{@project.id}/repos", { :repo => @repo_params },
                                               { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 201
      end

      it "create a new repo given valid data" do
        expect {
          post "/api/v1/projects/#{@project.id}/repos", { :repo => @repo_params },
                                                 { "HTTP_ACCEPT" => "application/json" }
        }.to change{@project.repos.count}.by(1)
      end
    end

    describe "with invalid params" do
      use_vcr_cassette

      before :each do
        @project = FactoryGirl.create(:project)
        @repo_params = FactoryGirl.build(:repo, github_url: "").as_json
      end

      it "responds with 422" do
        post "/api/v1/projects/#{@project.id}/repos", { :repo => @repo_params },
                                                 { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 422
      end

      it "rejects repo with invalid data" do
        expect {
          post "/api/v1/projects/#{@project.id}/repos", { :repo => @repo_params },
                                                   { "HTTP_ACCEPT" => "application/json" }
        }.to change{Repo.count}.by(0)

        body = JSON.parse(response.body)
        body["errors"].should include("github_url")
      end
    end
  end
end
