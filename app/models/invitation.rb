class Invitation
  include Mongoid::Document
  field :accepted, type: Mongoid::Boolean
  field :rejected, type: Mongoid::Boolean

  field :message, type: String

  belongs_to :from, class_name: "User", inverse_of: :outcoming_invitations
  belongs_to :to, class_name: "User", inverse_of: :incoming_invitations

  validates :from, :to, presence: true

  validate :cant_invite_one_person_twice, on: :create
  validate :cant_invite_user_who_blocked_you

  def cant_invite_one_person_twice
    if Invitation.where(from: self.from, to: self.to).any?
      errors[:base] << "You can't invite one person twice"
    end
  end

  def cant_invite_user_who_blocked_you
    if to and to.blocks_user_with_id? from.id
      errors["base"] << "You were blocked by this user"
    end
  end

  def accept!
    update!(accepted: true)
  end
end
