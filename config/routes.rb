Rails.application.routes.draw do
  resources :recipe_tags
  # resources :tags
  resources :comments
  resources :likes
  resources :recipes, except: [:show]
  resources :users

  post "/login", to: "users#login"
  get "/get_user", to: "users#get_user"

  delete "/likes", to: "likes#destroy"

  get "/users/:user_id/like_recipes", to: "recipes#like_recipes"
  get "/tags/:tag_name/tag_recipes", to: "recipes#tag_recipes"
  
  get "/search_tags/:search_term", to: "tags#search_tags"
  get "/search_recipes/:search_term", to: "recipes#search_recipes"

  get "/recipes/newest", to: "recipes#newest"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
