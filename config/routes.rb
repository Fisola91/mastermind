Rails.application.routes.draw do
  resources :games, only: %i(new create show) do
    collection do
      post :player_passcode
    end
    resources :attempts, only: %i(create)
  end

  resources :sessions, only: %i(new create destroy)
  root to: "games#index"
end
