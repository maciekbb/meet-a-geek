require 'spec_helper'

describe User, :type => :model do
  describe "invitations" do
    it "can invite another user" do
      user_a = User.create(name: "Maciek")
      user_b = User.create(name: "Krzysiek")
      invitation = user_a.outcoming_invitations.create(to: user_b)

      expect(invitation.from).to eq user_a
      expect(invitation.to).to eq user_b

      expect(user_b.incoming_invitations).to eq [invitation]
    end
  end

end
