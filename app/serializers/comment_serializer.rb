class CommentSerializer < ActiveModel::Serializer
    attributes :id, :text, :user

    def user
        User.find(self.object.user_id).username
    end
end