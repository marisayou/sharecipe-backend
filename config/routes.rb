Rails.application.routes.draw do

  resources :subscriptions, only: [:create]
  resources :comments
  resources :likes
  resources :recipes, except: [:show]
  resources :users

  post "/login", to: "users#login"
  get "/get_user", to: "users#get_user"

  # get all the recipes the user has created
  get "/users/:user_id/recipes", to: "recipes#user_recipes"

  delete "/likes", to: "likes#destroy"

  # get all the recipes the user has favorited
  get "/users/:user_id/like_recipes", to: "recipes#like_recipes"

  # get all the recipes that have a particular tag
  get "/tags/:tag_name/tag_recipes", to: "recipes#tag_recipes"
  
  # get search results
  get "/searches/:search_term", to: "searches#get_search_results"

  get "/recipes/newest", to: "recipes#newest"

  delete "/subscriptions", to: "subscriptions#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
