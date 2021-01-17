class TagSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :recipes, through: :recipe_tags
end
