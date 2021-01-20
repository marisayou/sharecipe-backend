class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :recipes, :favorites
  has_many :recipes

  def favorites
    self.object.like_recipes.map do |recipe|
      recipe.id
    end
  end

end
