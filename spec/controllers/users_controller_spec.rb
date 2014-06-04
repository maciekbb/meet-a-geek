require 'spec_helper'

describe UsersController, :type => :controller do
  let(:user) { User.create(name: "Maciek", auth_token: "abc") }

  before(:each) do
    request.headers['Authorization'] = token_header(user.auth_token)
  end

  describe "GET 'matches'" do
    it "returns http success" do
      get 'matches'
      expect(response.status).to eq 200
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create', { user: { name: "Piotrek", coordinate_attributes: { location: [20, 10] } } }

      new_user = JSON.parse(response.body)
      expect(new_user["name"]).to eq "Piotrek"
      expect(new_user["auth_token"]).to be_present
      expect(response.status).to eq 201
    end
  end

  describe "PATCH 'update'" do
    it "returns http success" do
      patch 'update', { user: { coordinate_attributes: { location: [10, 20] } } }

      expect(response.status).to eq 200
      expect(user.reload.coordinate.location).to eq [10, 20]
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy'
      expect(response.status).to eq 204
    end
  end

end