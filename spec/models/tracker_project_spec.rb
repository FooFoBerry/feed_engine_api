require 'spec_helper'

describe TrackerProject do
  describe "it should not be valid" do 
    it "without a pivotal project id" do
      FactoryGirl.build(:tracker_project, :pt_project_id => nil).should_not be_valid
    end
  end
end
