require 'spec_helper'

describe UsersController, :type => :controller do
  let(:user) { User.create(name: "Maciek", auth_token: "abc") }

  before(:each) do
    request.headers['Authorization'] = token_header(user.auth_token)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response.status).to eq 200
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create', { user: { name: "Maciek", coordinate_attributes: { location: [20, 10] } } }
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

  describe "DELETE 'delete'" do
    it "returns http success" do
      get 'delete'
      expect(response.status).to eq 204
    end
  end

end
