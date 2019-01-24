Rails.application.routes.draw do
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  devise_for :users
  root to: 'home#index'
  
  resources :listings
  get 'smartthings_oauth/callback', to: 'smartthings_oauth#create'
end
