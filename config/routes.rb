Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/gamestart", to: "web_games#index"
  # verb "/path", to: "controller#action"
end
