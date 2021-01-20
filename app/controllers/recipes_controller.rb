class RecipesController < ApplicationController

    def show 
        recipe = Recipe.find(params[:id])
        render json: recipe
    end

    def index
        recipes = Recipe.all
        render json: recipes
    end

    def like_recipes
        # byebug
        user = User.find(params[:user_id])
        
        render json: user.like_recipes
    end

    def create
        # create recipe
        recipe = Recipe.create(user_id: params[:user_id], recipe: params[:recipe].to_json)
        # find or create tags, then join with recipe by creating recipe_tags
        params[:tags].each do |t|
            tag = Tag.find_or_create_by(name: t)
            RecipeTag.find_or_create_by(recipe_id: recipe.id, tag_id: tag.id)
        end
        render json: recipe
    end

    def update
        # update recipe
        recipe = Recipe.find(params[:id])
        recipe.update(recipe: params[:recipe].to_json)
        
        # update recipe_tags
        # create new tags and recipe_tags if new tags have been added
        # remove recipe_tags if old tags have been removed
        old_tags = recipe.tags.map {|t| t.name}
        new_tags = params[:tags]

        create_tags = new_tags - old_tags
        create_tags.each do |t|
            tag = Tag.find_or_create_by(name: t)
            RecipeTag.create(recipe_id: recipe.id, tag_id: tag.id)
        end

        remove_tags = old_tags - new_tags
        remove_tags.each do |t|
            tag = Tag.find_by(name: t)
            recipe_tag = RecipeTag.find_by(recipe_id: recipe.id, tag_id: tag.id)
            recipe_tag.destroy
        end
        
        render json: Recipe.find(params[:id])
    end

    def destroy
        recipe = Recipe.find(params[:id])
        recipe.destroy
    end
end
