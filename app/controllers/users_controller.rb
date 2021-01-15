class UsersController < ApplicationController

    def login
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            token = encode_token(user_id: user.id)
            render json: {user: user, token: token}
            # render json: {user: UserSerializer.new(user), token: token}
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
        render json: user
    end

    def create
        user = User.new(user_params)
        if user.save
            token = encode_token({user_id: user.id})
            render json: {user: user, token: token}
            # render json: {user: UserSerialize.new(user), token: token}
        else
            render json: {error: "This username is taken. Please try again."}
        end
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)

        render json: {user: user}
    end

    private
    def user_params
        params.permit(:name, :username, :password)
    end
end
