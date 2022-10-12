Rails.application.routes.draw do
  resources :battles
  devise_for :users
  get "home/index"
  get "/leaderboard", to: "home#leaderboard"

  # Defines the root path route ("/")
  root to: "home#index"
end
