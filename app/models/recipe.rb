class Recipe < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :like_users, :through => :likes, :source => :users
  has_many :comments
  has_many :comment_users, :through => :comments, :source => :users
end
