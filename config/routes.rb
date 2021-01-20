Rails.application.routes.draw do
  resources :recipe_tags
  resources :tags
  resources :comments
  resources :likes
  resources :recipes
  resources :users

  post "/login", to: "users#login"
  get "/get_user", to: "users#get_user"

  delete "/likes", to: "likes#destroy"

  get "/users/:user_id/like_recipes", to: "recipes#like_recipes"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
