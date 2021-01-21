class TagsController < ApplicationController

    def search_tags
        tags = Tag.query_tags(params[:search_term])
        render json: tags
    end
end
