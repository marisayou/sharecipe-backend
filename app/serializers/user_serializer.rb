class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :favorites

  def favorites
    self.object.like_recipes.map do |recipe|
      recipe.id
    end
  end

end
