# Post Serializer
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :views
  has_one :user
  has_one :account
end
