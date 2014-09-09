require 'spec_helper'

describe BlockUsersController, :type => :controller do
  let!(:user) { User.create(name: "maciek", description: "desc", password: "abc") }

  before(:each) do
    request.headers['Authorization'] = token_header(user.auth_token)
  end

  describe "POST 'create'" do
    it "blocks an user" do
      post :create, { user_id: "3" }, {}

      expect(user.reload.blocked_users_ids).to eq ["3"]
    end
  end

  describe "DELETE 'destroy'" do
    it "unblocks an user" do
      user.block_user_with_id("3")
      expect(user.reload.blocked_users_ids).to eq ["3"]
      delete :destroy, { user_id: "3" }, {}

      expect(user.reload.blocked_users_ids).to eq []
    end
  end
end
