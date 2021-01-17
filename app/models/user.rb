class User < ApplicationRecord
    has_many :recipes, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :like_recipes, :through => :likes, :source => :recipe
    has_many :comments, dependent: :destroy
    has_many :comment_recipes, :through => :comments, :source => :recipe
    has_secure_password
end
