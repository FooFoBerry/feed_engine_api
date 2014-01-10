require 'spec_helper'

describe Repo do
  describe "it should not be valid" do
    it "without a github_url" do
      FactoryGirl.build(:repo, :github_url => "").should_not be_valid
    end
  end

  describe "commit association" do
    it "has commits" do
      repo = FactoryGirl.create(:repo)
      FactoryGirl.create(:commit, commit_hash: "1234", repo_id: repo.id)
      expect(repo.commits.map(&:commit_hash)).to match_array(["1234"])
    end

    it "has projects" do
      repo = FactoryGirl.create(:repo)
      project = FactoryGirl.create(:project, name: "FooFoo")
      repo.projects << project
      expect(repo.projects.map(&:name)).to match_array(["FooFoo"])
    end
  end
end
