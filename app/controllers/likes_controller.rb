class LikesController < ApplicationController

    def create
        like = Like.find_or_create_by(like_params)
    end

    def destroy
        like = Like.find_by(like_params)
        like.destroy
    end

    private
    def like_params
        params.require(:like).permit(:user_id, :recipe_id)
    end
end
