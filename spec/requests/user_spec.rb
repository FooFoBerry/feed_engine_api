require 'spec_helper'

describe "User API"  do
  describe "GET/users" do 
    it "returns all the users" do 
      FactoryGirl.create :user, name: "FooFo"
      FactoryGirl.create :user, name: "Berry"

      get "/users", {}, { "HTTP_ACCEPT" => "application/json"}
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      user_names = body.map { |user| user["name"] }

      expect(user_names).to match_array(["FooFo", "Berry"])   
    end
  end
end
  
