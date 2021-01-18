class RecipeSerializer < ActiveModel::Serializer
    attributes :id, :recipe
    
    # def user
    #     user = self.object.user
    #     return {
    #         id: user.id,
    #         name: user.name,
    #         username: user.username
    #     }
    # end
  end
  