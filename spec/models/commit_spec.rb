require 'spec_helper'

describe Commit do
  describe "it should not be valid" do
    it "without a commit_hash" do
      FactoryGirl.build(:commit, :commit_hash => "").should_not be_valid
    end
  end
end
