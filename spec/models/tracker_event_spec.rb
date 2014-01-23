require 'spec_helper'

describe TrackerEvent do
  describe "it should not be valid" do 
    it "without a pivotal story id" do
      FactoryGirl.build(:tracker_event, :story_id => nil).should_not be_valid
    end
  end
end
