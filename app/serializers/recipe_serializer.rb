class RecipeSerializer < ActiveModel::Serializer
    attributes :id, :recipe, :user, :tags, :comments

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

    def comments
      self.object.comments.map do |comment|
        { id: comment.id, text: comment.text, user: comment.user.username }
      end
    end
  end
  