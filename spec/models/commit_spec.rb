require 'spec_helper'

describe Commit do
  describe "it should not be valid" do
    it "without a commit_hash" do
      FactoryGirl.build(:commit, :commit_hash => "").should_not be_valid
    end

    it "without an email" do
      FactoryGirl.build(:commit, :email => "").should_not be_valid
    end
  end

  describe "associations" do
    use_vcr_cassette

    it "has repos" do
      commit = FactoryGirl.create(:commit, commit_hash: "bubar")
      repo = FactoryGirl.create(:repo, github_url: "gh.com/galvanize")
      commit.repo = repo
      expect(commit.repo.github_url).to eq("gh.com/galvanize")
    end
  end
end
