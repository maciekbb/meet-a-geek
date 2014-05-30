class Invitation
  include Mongoid::Document
  field :accepted, type: Mongoid::Boolean
  field :rejected, type: Mongoid::Boolean

  field :message, type: String

  belongs_to :from, class_name: "User", inverse_of: :outcoming_invitations
  belongs_to :to, class_name: "User", inverse_of: :incoming_invitations
end
