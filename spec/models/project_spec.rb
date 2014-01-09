require 'spec_helper'

describe Project do
  describe "it should not be valid" do
    it "without a name" do
      FactoryGirl.build(:project, :name => "").should_not be_valid
    end
  end
end
