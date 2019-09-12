# Post model
class Post < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  belongs_to :account
  has_many :comments, class_name: 'Post', foreign_key: 'post_id'
  acts_as_taggable
  friendly_id :title, use: :slugged
end
