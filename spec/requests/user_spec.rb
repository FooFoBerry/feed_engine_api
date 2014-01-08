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

  describe "POST/users" do 
    before :each do 
      @user = FactoryGirl.build(:user).as_json(:except => ["id", "created_at", "updated_at"])
      @json = { :format => "json", :user => @user }
    end

    xit "creates a user that doesn't exist" do 
      #post params about a user 
      expect{ post "/users", @json }.to change{ User.count }.by(1)
    end

    xit "responds with 201" do 
      post "/users", @json
      expect(response.status).to eq 201 
      
    end
    xit "responds with user info" do 
      #body = JSON.parse(response.body)
      #user = 
      #check that a 201 status is returned to the user with user info 
    end
  end   
end
  
