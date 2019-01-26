Rails.application.routes.draw do
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  devise_for :users

  authenticated :user do
    root 'listings#index', as: :authenticated_root
  end

  root to: 'home#index'
  
  resources :listings do
    resources :reservations, only: [:create, :edit, :update, :destroy]
  end

  get 'smartthings_oauth/callback', to: 'smartthings_oauth#create'
end
