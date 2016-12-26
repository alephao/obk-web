class AdminSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :uid
end