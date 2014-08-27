class UserWithAuthTokenSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :description, :auth_token
end
