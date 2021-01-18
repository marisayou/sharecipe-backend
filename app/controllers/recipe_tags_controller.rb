class RecipeTagsController < ApplicationController

    def create
        recipe_tag = RecipeTag.find_or_create_by(recipe_tag_params)
        render json: recipe_tag
    end

    private
    def recipe_tag_params
        params.require(:recipe_tag).permit(:tag_id, :recipe_id)
    end
end
