class User < ApplicationRecord
    has_many :recipes
    has_many :likes
    has_many :like_recipes, :through => :likes, :source => :recipes
    has_many :comments
    has_many :comment_recipes, :through => :comments, :source => :recipes
end
