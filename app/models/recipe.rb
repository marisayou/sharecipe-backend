class Recipe < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, :through => :likes, :source => :user
  has_many :comments, dependent: :destroy
  has_many :comment_users, :through => :comments, :source => :user
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, :through => :recipe_tags

  has_one_attached :image

  default_scope { order(created_at: :desc) }

  def get_image_url
    url_for(self.image)
  end

  def self.select_featured
    self.all.slice(0, 5)
  end
end
