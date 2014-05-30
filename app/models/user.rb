class User
  include Mongoid::Document
  field :name, type: String
  field :auth_token, type: String

  has_many :incoming_invitations, class_name: "Invitation", inverse_of: :to
  has_many :outcoming_invitations, class_name: "Invitation", inverse_of: :from

  has_one :coordinate
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :coordinate

  def able_to_meet? (another_user)
    Invitation.where(from: self, to: another_user, accepted: true).any? or
    Invitation.where(from: another_user, to: self, accepted: true).any?
  end

  def matches
    if coordinate
      Coordinate.near(coordinate.location, 100).map(&:user).find_all do |user|
        (user.tags & tags).size > 0
      end
    else
      []
    end
  end
end
