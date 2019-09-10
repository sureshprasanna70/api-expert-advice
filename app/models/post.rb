# Post model
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :account
  has_many :comments,:class_name => "Post",:foreign_key => "parent_id"
  acts_as_taggable
end
