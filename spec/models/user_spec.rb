require 'spec_helper'

describe User, :type => :model do
  before(:each) do
    Coordinate.destroy_all
    Tag.destroy_all
  end

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

  describe "tags" do
    it "can have multiple tags" do
      java = Tag.create(name: "java")
      python = Tag.create(name: "python")

      user = User.create(name: "Maciek")
      user.tags << java
      user.tags << python

      expect(user.tags).to eq [java, python]
      expect(java.users).to eq [user]
    end
  end

  after(:each) do
    User.destroy_all
    Tag.destroy_all
  end

end
