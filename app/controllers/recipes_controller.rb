class RecipesController < ApplicationController

    def show 
        recipe = Recipe.find(params[:id])
        render json: recipe
    end

    def index
        recipes = Recipe.all
        render json: recipes
    end

    def create
        recipe = Recipe.create(user_id: params[:user_id], recipe: params[:recipe].to_json)
        render json: recipe
    end

    def update
        recipe = Recipe.find(params[:id])
        recipe.update(recipe: params[:recipe].to_json)
        render json: recipe
    end

    def destroy
        recipe = Recipe.find(params[:id])
        recipe.destroy
    end

    private
    def recipe_params
        params.permit(:user_id, :recipe)
    end
end
