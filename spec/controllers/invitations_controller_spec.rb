require 'spec_helper'

describe InvitationsController, :type => :controller do

  let(:user) { User.create(name: "Maciek", auth_token: "abc") }
  let(:another_user) { User.create(name: "Krzysiek") }

  before(:each) do
    request.headers['Authorization'] = token_header(user.auth_token)
  end

  describe "POST 'invite'" do
    it "invites another person" do
      post 'invite', { user_id: another_user.id }, {}
      expect(response.status).to eq 201

      invitation = JSON.parse(response.body)
      expect(invitation["from_id"]["$oid"]).to eq user.id.to_s
      expect(invitation["to_id"]["$oid"]).to eq another_user.id.to_s
    end

    it "invited user can't be nil" do

      request.headers['Authorization'] = token_header(user.auth_token)
      post 'invite', { user_id: nil }

      expect(response.status).to eq 422
    end
  end

  describe "POST 'accept'" do
    it "accepts a invitation" do
      invitation = Invitation.create(from: another_user, to: user)

      post 'accept', { invitation_id: invitation.id }
      expect(response.status).to eq 204

      expect(invitation.reload.accepted).to eq true
    end
  end

  describe "POST 'reject'" do
    it "rejects a invitation" do
      invitation = Invitation.create(from: another_user, to: user)

      post 'reject', { invitation_id: invitation.id }
      expect(response.status).to eq 204

      expect(invitation.reload.rejected).to eq true
    end
  end

  describe "GET 'incoming_invitations'" do
    it "returns http success" do
      get 'incoming_invitations'
      expect(response).to be_success
    end
  end

  describe "GET 'outcoming_invitations'" do
    it "returns http success" do
      get 'outcoming_invitations'
      expect(response).to be_success
    end
  end

end
