Rails.application.routes.draw do
  resources :recipe_ingredients
  resources :comments
  resources :likes
  resources :ingredients
  resources :recipes
  resources :users

  post "/login", to: "users#login"
  get "/getuser", to: "users#get_user"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
