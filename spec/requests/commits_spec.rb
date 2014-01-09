require 'spec_helper'

describe "Commits API" do
  describe "GET /projects/:project_id/commits" do
    it "returns all the project's commits" do
      commit = FactoryGirl.create :commit, commit_hash: "098abc"
      commit2 = FactoryGirl.create :commit, commit_hash: "765qwe"
      commit3 = FactoryGirl.create :commit, commit_hash: "foobar"
      commit3.project_id = 2
      commit3.save

      get "/projects/#{commit.project_id}/commits"

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      commit_hashes = body.map { |c| c["commit_hash"] }

      expect(commit_hashes).to match_array(["098abc",
                                            "765qwe"])
    end
  end

  describe "GET /projects/:project_id/commits/:id" do
    it "returns the right commit" do
      commit = FactoryGirl.create :commit, commit_hash: "qwer1", project_id: 1

      get "/projects/1/commits/#{commit.id}"
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      commit_hash = body["commit_hash"]

      expect(commit_hash).to eq("qwer1")
    end
  end

  describe "POST /projects/:project_id/commits" do
    describe "with valid params" do
      before :each do
        @project = FactoryGirl.create(:project)
        @commit_params = FactoryGirl.build(:commit).as_json(:except => [:project_id])
      end

      it "responds with 201" do
        post "/projects/#{@project.id}/commits", { :commit => @commit_params }, { "HTTP_ACCEPT" => "application/json" }
        expect(response.status).to eq 201
        expect(Commit.last.project_id).to eq(@project.id)
      end

      it "creates a new commit given valid data" do
        expect {
          post "/projects/#{@project.id}/commits", { :commit => @commit_params }, { "HTTP_ACCEPT" => "application/json" }
        }.to change{Commit.count}.by(1)
      end
    end

    describe "with invalid params" do
      before :each do
        #
      end

      it "responds with 422" do
        #
      end

      it "creates a new project given valid data" do
        #
      end
    end
  end

end
