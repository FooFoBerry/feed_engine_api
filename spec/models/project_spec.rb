require 'spec_helper'

describe Project do

  describe "it should be valid" do
    it "with the correct attributes" do
      p = FactoryGirl.build(:project, :name => "FooFoBerry", :user_id => 1)
      expect(p).to be_valid
    end
  end

  describe "it should not be valid" do
    it "without a name" do
      FactoryGirl.build(:project, :name => "").should_not be_valid
    end

    it "without a user_id" do
      FactoryGirl.build(:project, :user_id => nil).should_not be_valid
    end
  end

  describe "project_repos association" do
    it "has project_repos" do
      project = FactoryGirl.create(:project)
      repo = FactoryGirl.create(:repo, :github_url => "gh.com/kevin")
      project.repos << repo
      expect(project.repos.map(&:github_url)).to match_array(["gh.com/kevin"])
    end
  end
end
