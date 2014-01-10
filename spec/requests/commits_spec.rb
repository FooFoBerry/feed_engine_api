require 'spec_helper'

describe "Commits API" do
  describe "GET /projects/:project_id/commits" do
    it "returns all the project's commits" do
      project = FactoryGirl.create :project
      repo = FactoryGirl.create :repo
      project.repos << repo
      commit = FactoryGirl.create :commit, commit_hash: "098abc", repo: repo
      commit2 = FactoryGirl.create :commit, commit_hash: "765qwe", repo: repo
      commit3 = FactoryGirl.create :commit, commit_hash: "foobar"

      get "/projects/#{project.id}/commits"

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      commit_hashes = body.map { |c| c["commit_hash"] }

      expect(commit_hashes).to match_array(["098abc",
                                            "765qwe"])
    end
  end

  describe "GET /projects/:project_id/commits/:id" do
    it "returns the right commit" do
      project = FactoryGirl.create :project
      repo = FactoryGirl.create :repo
      project.repos << repo
      commit = FactoryGirl.create :commit, commit_hash: "qwer1", repo: repo

      get "/projects/1/commits/#{commit.id}"
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      commit_hash = body["commit_hash"]

      expect(commit_hash).to eq("qwer1")
    end
  end

  describe "POST /repos/:repo_id/commits" do
    describe "with valid params" do
      before :each do
        @repo = FactoryGirl.create(:repo)
        @commit_params = FactoryGirl.build(:commit).as_json(:except => [:repo_id])
      end

      it "responds with 201" do
        post "/repos/#{@repo.id}/commits", { :commit => @commit_params },
                                           { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 201
        expect(Commit.last.repo_id).to eq(@repo.id)
      end

      it "creates a new commit given valid data" do
        expect {
          post "/repos/#{@repo.id}/commits", { :commit => @commit_params },
                                                { "HTTP_ACCEPT" => "application/json" }
        }.to change{Commit.count}.by(1)

        body = JSON.parse(response.body)
        body["id"].should be_kind_of(Fixnum)
        body["repo_id"].should eq(@repo.id)
      end
    end

    describe "with invalid params" do
      before :each do
        @repo = FactoryGirl.create(:repo)
        @commit_params = FactoryGirl.build(:commit, :commit_hash => "").as_json
      end

      it "responds with 422" do
        post "/repos/#{@repo.id}/commits", { :commit => @commit_params },
                                           { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 422
      end

      it "rejects a new project given invalid data" do
        expect {
          post "/repos/#{@repo.id}/commits", { :commit => @commit_params },
                                             { "HTTP_ACCEPT" => "application/json" }
        }.to change{Commit.count}.by(0)

        body = JSON.parse(response.body)
        body["errors"].should include("commit_hash")
      end
    end
  end

end
