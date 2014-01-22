require 'spec_helper'

describe ApplicationController do
  before :each do
    cookies[:user_id] = 123
  end

  describe "the current_user" do
    it "should be set in the cookie" do
      expect(subject.current_user.id).to eq(123)
    end
  end
end
