class SearchesController < ApplicationController

    def get_search_results
        search_term = params[:search_term]

        # find recipes
        recipe_results = Search.query_searches(search_term, "recipe")
        recipes = recipe_results.map do |result|
            Recipe.find(result[:resource_id])
        end

        # find tags
        tag_results = Search.query_searches(search_term, "tag")
        tags = tag_results.map do |result|
            Tag.find(result[:resource_id])
        end

        # find users
        user_results = Search.query_searches(search_term, "user")
        users = user_results.map do |result|
            User.find(result[:resource_id])
        end

        render json: {
            recipes: recipes.map {|recipe| RecipeSerializer.new(recipe)},
            tags: tags.map {|tag| TagSerializer.new(tag)},
            users: users.map {|user| UserSerializer.new(user)}
        }
    end
end