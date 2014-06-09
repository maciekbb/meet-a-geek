require 'spec_helper'

describe TagsController, :type => :controller do
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

  describe "PATCH 'update'" do
    it "returns http success" do
      patch 'update', { tags: ["java", "c++"] }

      expect(response.status).to eq 200
      expect(response.body).to match "java"
      expect(user.reload.tags.map(&:name).to_set).to eq ["java", "c++"].to_set
    end
  end

end
