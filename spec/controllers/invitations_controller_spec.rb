require 'spec_helper'

describe InvitationsController, :type => :controller do

  let(:user) { User.create(name: "Maciek", password: "test") }
  let(:another_user) { User.create(name: "Krzysiek", password: "test") }

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
      patch 'invite', { user_id: nil }

      expect(response.status).to eq 422
    end

    it "can't invite one person twice" do
      post 'invite', { user_id: another_user.id }, {}
      expect(response.status).to eq 201

      post 'invite', { user_id: another_user.id }, {}
      expect(response.status).to eq 422
    end

    it "can't invite user you were blocked by" do
      another_user.blocked_users_ids = [user.id]
      another_user.save!

      post 'invite', { user_id: another_user.id }, {}

      status = JSON.parse(response.body)
      expect(response.status).to eq 422
    end
  end

  describe "POST 'accept'" do
    it "accepts a invitation" do
      invitation = Invitation.create(from: another_user, to: user)

      patch 'accept', { invitation_id: invitation.id }
      expect(response.status).to eq 204

      expect(invitation.reload.accepted).to eq true
    end

    it "accepts a invitation by user_id" do
      invitation = Invitation.create(from: another_user, to: user)

      patch 'accept', { user_id: another_user.id }
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

    it "rejects a invitation by user_id" do
      invitation = Invitation.create(from: another_user, to: user)

      post 'reject', { user_id: another_user.id }
      expect(response.status).to eq 204

      expect(invitation.reload.rejected).to eq true
    end
  end

  describe "POST 'cancel'" do
    describe "by invitation_id" do
      it "cancels a own invitation" do
        invitation = Invitation.create(from: another_user, to: user, accepted: true)

        post 'cancel', { invitation_id: invitation.id }
        expect(response.status).to eq 200
      end

      it "cancels a received invitation" do
        invitation = Invitation.create(from: user, to: another_user, accepted: true)

        post 'cancel', { invitation_id: invitation.id }
        expect(response.status).to eq 200
      end
    end

    describe "by user_id" do
      it "cancels a own invitation" do
        invitation = Invitation.create(from: another_user, to: user, accepted: true)

        post 'cancel', { user_id: user.id }
        expect(response.status).to eq 200
      end

      it "cancels a received invitation" do
        invitation = Invitation.create(from: user, to: another_user, accepted: true)

        post 'cancel', { user_id: another_user.id }
        expect(response.status).to eq 200
      end
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
