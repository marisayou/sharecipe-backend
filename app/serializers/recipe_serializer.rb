class RecipeSerializer < ActiveModel::Serializer
    attributes :id, :recipe, :user, :tags, :comments, :image_url

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
    
    def image_url
      self.object.image ? self.object.get_image_url : ""
    end
    # def serialize_recipe(recipe)
    #   {
    #     id: recipe.id,
    #     image_url: recipe.get_image_url
        
    #   }
    # end
  end
  