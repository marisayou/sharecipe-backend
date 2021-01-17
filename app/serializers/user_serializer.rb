class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :recipes, :like_recipes, :like_count
  has_many :recipes

  def like_count
    self.object.like_recipes.count
  end
end
