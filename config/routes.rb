Rails.application.routes.draw do
  resources :games, only: %i(new create show) do
    resources :attempts, only: %i(create)
  end

  resources :sessions, only: %i(new create destroy)
  root to: "games#index"
end
