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

  describe "able to meet" do
    let(:user_a) { User.create(name: "Maciek")  }
    let(:user_b) { User.create(name: "Piotrek")  }

    it "can't meet when no invitations" do
      expect(user_a).not_to be_able_to_meet(user_b)
      expect(user_b).not_to be_able_to_meet(user_a)
    end

    it "can't meet when invitation isn't acceted" do
      invitation = Invitation.create(from: user_a, to: user_b)

      expect(user_a).not_to be_able_to_meet(user_b)
      expect(user_b).not_to be_able_to_meet(user_a)
    end

    it "can meet when exists accepted invitation" do
      invitation = Invitation.create(from: user_a, to: user_b, accepted: true)

      expect(user_a).to be_able_to_meet(user_b)
      expect(user_b).to be_able_to_meet(user_a)
    end
  end

  describe "matches" do

    let(:user_a) { User.create(name: "Maciek", coordinate_attributes: { location: [10, 20] })  }
    let(:user_b) { User.create(name: "Piotrek", coordinate_attributes: { location: [10, 20] })  }

    let(:java) { Tag.create(name: "java") }
    let(:python) { Tag.create(name: "python") }

    it "are matches when share tags" do
      user_a.tags << java
      user_b.tags << java

      expect(user_a.matches).to include(user_b)
      expect(user_b.matches).to include(user_a)
    end

    it "arent matches when dont share tags" do
      user_a.tags << java
      user_b.tags << python

      expect(user_a.matches).not_to include(user_b)
      expect(user_b.matches).not_to include(user_a)
    end
  end

end
