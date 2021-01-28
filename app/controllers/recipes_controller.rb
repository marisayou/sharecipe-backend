class RecipesController < ApplicationController

    def index
        recipes = Recipe.all
        render json: recipes
    end

    def featured
        recipes = Recipe.select_featured
        render json: recipes
    end

    def user_recipes
        user = User.find(params[:user_id])
        render json: user.recipes
    end

    def like_recipes
        user = User.find(params[:user_id])
        render json: user.like_recipes
    end

    def tag_recipes
        tag = Tag.find_by(name: params[:tag_name])
        render json: tag.recipes
    end

    def create
        # get title, tags, and ingredients on the new recipe
        title = JSON.parse(params[:recipe])["title"].downcase
        tags = params[:tags].split(" ")
        # unique array of ingredient names that are not included in the recipe's title
        ingredients = JSON.parse(params[:recipe])["ingredients"].map do |ing|
             ing["ingredient"].downcase
        end.select do |name| 
            !title.include?(name)
        end.uniq

        # create recipe
        recipe = Recipe.create(user_id: params[:user_id], recipe: JSON.parse(params[:recipe]), image: params[:image])

        # create Search entry for title
        Search.create(search_term: title, resource_type: "recipe", resource_id: recipe.id)

        # create Search entry for each ingredient
        ingredients.each do |ing| 
            Search.create(search_term: ing, resource_type: "recipe", resource_id: recipe.id)
        end
        
        # find or create tags, then join with recipe by creating recipe_tags
        tags.each do |t|
            tag = Tag.find_or_create_by(name: t.downcase)
            RecipeTag.create(recipe_id: recipe.id, tag_id: tag.id)

            # find or create Search entry for each tag
            Search.find_or_create_by(search_term: t.downcase, resource_type: "tag", resource_id: tag.id)
        end

        render json: recipe
    end

    def update
        # find old recipe
        recipe = Recipe.find(params[:id])
        old_recipe = recipe.recipe
        
        # update search by title
        new_title = JSON.parse(params[:recipe])["title"]
        if old_recipe["title"] != new_title
            title_search = Search.find_by(search_term: old_recipe["title"].downcase, resource_type: "recipe", resource_id: recipe.id)
            title_search.update(search_term: new_title.downcase)
        end

        # update searches by ingredient
        # delete searches for ingredients in the old recipe that are not in the new recipe
        # create searches for ingredients in the new recipe that are not in the old recipe
        old_ingredients = old_recipe["ingredients"].map do |ing|
            ing["ingredient"]
        end
        new_ingredients = JSON.parse(params[:recipe])["ingredients"].map do |ing|
            ing["ingredient"]
        end
        
        delete_ingredient_searches = old_ingredients - new_ingredients
        
        delete_ingredient_searches.each do |i|
            search = Search.find_by(search_term: i, resource_type: "recipe", resource_id: recipe.id)
            search.destroy
        end

        create_ingredient_searches = new_ingredients - old_ingredients
        create_ingredient_searches.each do |i|
            Search.create(search_term: i, resource_type: "recipe", resource_id: recipe.id)
        end

        # update recipe_tags
        # remove recipe_tags of any tags from the old recipe that are not in the new recipe
        # create new tags and recipe_tags for tags that have been added
        old_tags = recipe.tags.map {|t| t.name}
        new_tags = params[:tags].split(" ")
        remove_tags = old_tags - new_tags
        
        remove_tags.each do |t|
            tag = Tag.find_by(name: t)
            
            recipe_tag = RecipeTag.find_by(recipe_id: recipe.id, tag_id: tag.id)
            recipe_tag.destroy
        
            # delete tags that will have no more recipes after it's removed from this recipe
            if (tag.recipe_tags.length == 0) 
                # delete searches related to this tag
                delete_tags = "DELETE FROM searches WHERE resource_type = 'tag' AND resource_id = #{tag.id}"
                ActiveRecord::Base.connection.execute(delete_tags)
                tag.destroy
            end
        end

        create_tags = new_tags - old_tags
        create_tags.each do |t|
            tag = Tag.find_or_create_by(name: t)
            RecipeTag.create(recipe_id: recipe.id, tag_id: tag.id)
            
            # find or create Search entry for each tag
            Search.find_or_create_by(search_term: t.downcase, resource_type: "tag", resource_id: tag.id)
        end
        
        # update recipe
        params[:image] != "undefined" ?
        recipe.update(recipe: JSON.parse(params[:recipe]), image: params[:image]) :
        recipe.update(recipe: JSON.parse(params[:recipe]))

        render json: Recipe.find(recipe.id)
    end

    def destroy
        recipe = Recipe.find(params[:id])

        # delete searches related to this recipe
        delete_searches = "DELETE FROM searches WHERE resource_type = 'recipe' AND resource_id = #{recipe.id}"
        ActiveRecord::Base.connection.execute(delete_searches)

        # delete tags that will have no more recipes after this recipe is deleted
        tags = recipe.tags.each do |tag|
            if (tag.recipe_tags.length == 1) 
                # delete searches related to this tag
                delete_tags = "DELETE FROM searches WHERE resource_type = 'tag' AND resource_id = #{tag.id}"
                ActiveRecord::Base.connection.execute(delete_tags)
                tag.destroy
            end
        end

        recipe.destroy
    end
end

private 
def recipe_params

end
