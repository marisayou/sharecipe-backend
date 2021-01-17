class Recipe < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, :through => :likes, :source => :user
  has_many :comments, dependent: :destroy
  has_many :comment_users, :through => :comments, :source => :user
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, :through => :recipe_tags
end
