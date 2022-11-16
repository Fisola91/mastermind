Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :web_games do
    collection do
      get :new
      get :player_guess
    end
  end
  resources :sessions, only: %i(new create destroy)
  root to: "web_games#index"
  # get "/new_game", to: "web_games#new_game"
  # # verb "/path", to: "controller#action"
  # # get "/game/:code1/:code2/:code3/:code4", to: "web_games#player_guess"
  # get "/player_guess", to: "web_games#player_guess"
end
