class Invitation
  include Mongoid::Document
  field :accepted, type: Mongoid::Boolean
  field :rejected, type: Mongoid::Boolean

  field :message, type: String

  belongs_to :from, class_name: "User", inverse_of: :outcoming_invitations
  belongs_to :to, class_name: "User", inverse_of: :incoming_invitations

  validates :from, :to, presence: true

  validate :cant_invite_one_person_twice, on: :create

  def cant_invite_one_person_twice
    if Invitation.where(from: self.from, to: self.to).any?
      errors[:base] << "You can't invite one person twice"
    end
  end

  def accept!
    update!(accepted: true)
  end
end
