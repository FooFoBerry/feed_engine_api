require 'spec_helper'

describe Repo do
  describe "it should not be valid" do
    it "without a github_url" do
      FactoryGirl.build(:repo, :github_url => "").should_not be_valid
    end
  end
end
