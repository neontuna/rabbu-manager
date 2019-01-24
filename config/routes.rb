Rails.application.routes.draw do
  resources :listings
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
