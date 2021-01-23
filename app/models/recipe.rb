class Recipe < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, :through => :likes, :source => :user
  has_many :comments, dependent: :destroy
  has_many :comment_users, :through => :comments, :source => :user
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, :through => :recipe_tags

  def self.select_newest
    ordered_recipes = self.order("created_at DESC")
    ordered_recipes.slice(0, 5)
  end
end
