require 'spec_helper'

describe "Repos API" do
  describe "GET /projects/:project_id/repos" do
    it "returns all the project's repos" do
      repo = FactoryGirl.create :repo, github_url: "http://gh.com/abc"
      repo2 = FactoryGirl.create :repo, github_url: "http://gh.com/123"
      repo3 = FactoryGirl.create :repo, github_url: "http://gh.com/def"
      project = FactoryGirl.create :project, name: "Biggy"
      project.repos << repo
      project.repos << repo2

      get "projects/#{project.id}/repos"

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      repos = body.map { |r| r["github_url"] }

      expect(repos).to match_array(["http://gh.com/abc",
                                    "http://gh.com/123"])
    end
  end
end
