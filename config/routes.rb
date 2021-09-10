Rails.application.routes.draw do
  
  root 'rps_games#new'
  
  resources :rps_games, only: [:new, :create] do
    collection do
      get :display
    end
  end
end
