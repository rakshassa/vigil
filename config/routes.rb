Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :menus do
    collection do
      get :dash
      get :wilderness
      get :start_game
      get :login
      get :healer
      get :heal
      get :trainer
      get :shop
    end
  end

  resources :fights do
    member do
      get :run
      get :attack
      get :backstab
    end
  end

  root "menus#login"
end
