class UserWithAuthTokenSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :description, :blocked_users_ids, :auth_token
end
