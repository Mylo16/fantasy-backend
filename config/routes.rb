Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resource :users, only: [:create]
  post "/login", to: "auth#login"
  get "/auto_login", to: "auth#auto_login"
  get "/user_is_authed", to: "auth#user_is_authed"
  post "/password_reset", to: "password_reset#create"
  put "/password_reset", to: "password_reset#update"

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      get 'general_summary', to: 'general_summary#index'

      resources :teams do
        resources :players, only: [:index, :create] # Nested players under teams
      end
    
      resources :players, only: [:show, :update, :destroy]
    
      resources :positions, only: [:index, :show, :create, :update, :destroy]
    
      resources :gameweeks do
        resources :fixtures do
          resources :stats
        end
      end
    
      resources :managers do
        resources :manager_histories, only: [:index, :create]
        resources :my_team, only: [:show, :update] # Manager has one MyTeam
      end
    
      resources :my_teams, only: [] do
        member do
          post 'add_player'
          delete 'remove_player/:player_id', to: 'my_teams#remove_player', as: :remove_player
          post 'transfer_player'
        end
      end
    
      resources :leagues do
        resources :league_participations, only: [:index, :create, :destroy]
        member do
          post :join
        end
      end
    
      # Non-nested routes for remaining resources
      resources :league_participations, only: [:index, :show]
      resources :manager_histories, only: [:index, :show]
    end
  end
end
