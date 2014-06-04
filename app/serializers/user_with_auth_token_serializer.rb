class UserWithAuthTokenSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :auth_token
end
