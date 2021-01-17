class RecipeSerializer < ActiveModel::Serializer
    attributes :id, :user, :recipe
    
    def user
        user = self.object.user
        return {
            id: user.id,
            name: user.name,
            username: user.username
        }
    end
  end
  