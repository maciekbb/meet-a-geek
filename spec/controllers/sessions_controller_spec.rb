require 'spec_helper'

describe SessionsController, :type => :controller do
  let!(:user) { User.create(name: "maciek", description: "desc", password: "abc") }


  describe "POST 'create'" do
    it "returns auth token" do
      post 'create', { name: "maciek", password: "abc" }

      new_user = JSON.parse(response.body)
      expect(new_user["name"]).to eq "maciek"
      expect(new_user["description"]).to eq "desc"
      expect(new_user["auth_token"]).to be_present
      expect(response.status).to eq 201
    end

    it "returns error if bad credentians" do
      post 'create', { name: "maciek", password: "def" }

      new_user = JSON.parse(response.body)
      expect(new_user["auth_token"]).not_to be_present
      expect(response.status).to eq 403
    end
  end
end
