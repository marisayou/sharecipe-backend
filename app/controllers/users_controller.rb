class UsersController < ApplicationController

    def login
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            token = encode_token(user_id: user.id)
            render json: {user: UserSerializer.new(user), token: token}
        else
            render json: {error: "Incorrect username or password."}
        end
    end

    def get_user
        render json: {user: UserSerializer.new(current_user)}
    end

    def index
        users = User.all
        render json: users
    end

    def show
        user = User.find(params[:id])
        recipes = user.recipes
        render json: {
            user: UserSerializer.new(user), 
            recipes: recipes.map {|recipe| RecipeSerializer.new(recipe)}
        }
    end

    def create
        user = User.new(user_params)
        if user.save
            token = encode_token({user_id: user.id})
            render json: {user: UserSerializer.new(user), token: token}
        else
            render json: {error: "This username is taken. Please try again."}
        end
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: {user: UserSerializer.new(user)}
    end

    def destroy
        user = User.find(params[:id])

        # get array of tags associated with the user's recipes
        tags = []
        user.recipes.each do |recipe|
            recipe.tags.each do |tag|
                tags << tag
            end
        end

        # destroy searches of the user's recipes
        recipe_ids = user.recipes.map {|recipe| recipe.id}
        Search.all.each do |search|
            if (search.resource_type == "recipe" && recipe_ids.include?(search.resource_id))
                search.destroy
            end
        end

        # delete user and all dependent recipes, likes, and comments
        user.destroy

        # delete all tags that no longer have any associated recipes
        tags.uniq.each do |tag|
            if (tag.recipe_tags.length == 0)
                search = Search.find_by(resource_type: "tag", resource_id: tag.id)
                search.destroy
                tag.destroy
            end
        end

    end

    private
    def user_params
        params.permit(:name, :username, :password)
    end
end
