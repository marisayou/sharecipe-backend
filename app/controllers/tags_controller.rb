class TagsController < ApplicationController

    def index
        tags = Tag.all
        render json: tags
    end

    def show
        tag = Tag.find(params[:id])
        render json: tag
    end

    def create
        tag = Tag.find_or_create_by(tag_params)
        render json: tag
    end

    private
    def tag_params
        params.require(:tag).permit(:name)
    end
end
