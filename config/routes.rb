Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "web_games#index"
  get "/new_game", to: "web_games#new_game"
  # verb "/path", to: "controller#action"
  get "/game/:code1/:code2/:code3/:code4", to: "web_games#player_guess"
  # get "/game/:guess1/:guess2/:guess3/:guess4", to: "web_games#player_guess"
end
