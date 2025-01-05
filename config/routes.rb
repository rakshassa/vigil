Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :menus do
    collection do
      get :dash
      get :wilderness
      post :start_game
      get :login
      get :healer
      post :heal
      get :training
      post :train
      get :bard
      post :bard_buff
    end
  end

  resources :shops do
    collection do
      get :shop
      get :shop_weapons
      get :shop_armor
      post :buy_weapon
      post :buy_armor

      get :jeweler
      post :buy_trinket

      get :alchemist
      post :buy_potion
      post :use_potion
      delete :discard_potion
    end
  end

  resources :fights do
    collection do
      get :boss
      post :run
      post :attack
      post :backstab
      get :select_prize
      post :prize_selection
    end
  end

  root "menus#login"
end
