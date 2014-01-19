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

  describe "gh_repo_id" do
    # :TODO: wrap in VCR
    it "is populated post_create" do
      repo = FactoryGirl.create(:repo, :github_url => "https://github.com/FooFoBerry/github_notification_dummy_app",
                                        :gh_repo_id => nil)
      expect(repo.gh_repo_id).to eq 16033562
    end
  end
end
