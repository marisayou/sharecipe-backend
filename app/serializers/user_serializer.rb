class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :recipes
  def recipes
    self.object.recipes.map do |recipe|
      {title: recipe.title}
    end
  end
end
