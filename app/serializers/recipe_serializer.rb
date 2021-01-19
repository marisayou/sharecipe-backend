class RecipeSerializer < ActiveModel::Serializer
    attributes :id, :recipe, :user, :tags

    def user
        user = self.object.user
        return {
            id: user.id,
            name: user.name,
            username: user.username
        }
    end

    def tags
      self.object.tags.map do |tag|
        { id: tag.id, name: tag.name }
      end
    end
  end
  