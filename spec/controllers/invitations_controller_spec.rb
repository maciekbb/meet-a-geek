require 'spec_helper'

describe InvitationsController, :type => :controller do

  describe "GET 'invite'" do
    it "returns http success" do
      get 'invite'
      expect(response).to be_success
    end
  end

  describe "GET 'accept'" do
    it "returns http success" do
      get 'accept'
      expect(response).to be_success
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
