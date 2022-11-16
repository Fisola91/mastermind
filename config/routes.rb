Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "articles#index"

  # resources :web_games do
  #   get :new, on: :collection
  # end
  resources :games, only: %i(create show)
  # do
  #   # member do
  #   #   get :guess
  #   # end
  # end

  # resources :web_games do
  #   get :player_guess, on: :member
  # end

  resources :sessions, only: %i(new create destroy)
  root to: "games#index"
  # get "/new_game", to: "web_games#new_game"
  # # verb "/path", to: "controller#action"
  # # get "/game/:code1/:code2/:code3/:code4", to: "web_games#player_guess"
  # get "/player_guess", to: "web_games#player_guess"
end
