require 'spec_helper'

describe User, :type => :model do

  describe "invitations" do
    let(:user_a) { User.create(name: "Maciek")  }
    let(:user_b) { User.create(name: "Piotrek")  }

    it "can invite another user" do
      invitation = user_a.outcoming_invitations.create(to: user_b)

      expect(invitation.from).to eq user_a
      expect(invitation.to).to eq user_b

      expect(user_b.incoming_invitations).to eq [invitation]
    end
  end

  describe "tags" do
    let(:java) { Tag.create(name: "java") }
    let(:python) { Tag.create(name: "python") }
    let(:user) { User.create(name: "Maciek")  }

    it "can have multiple tags" do
      user.tags << java
      user.tags << python

      expect(user.tags).to eq [java, python]
      expect(java.users).to eq [user]
    end
  end

end
