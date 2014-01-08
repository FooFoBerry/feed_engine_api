require 'spec_helper'

describe User do
  it "creates a user given valid attributes" do
    FactoryGirl.create(:user).should be_valid
    FactoryGirl.build(:user).should_not be_valid
  end

end
