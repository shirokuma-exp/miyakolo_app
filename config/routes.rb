Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :home, only: [:index, :show]
  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :maps, only: [:index]
  resources :posts, only: [:index,:new,:create,:show,:destroy] do
    resources :likes, only: [:create, :destroy]
  end
  get 'search' => 'search#index'
  get '/map_request', to: 'maps#map', as: 'map_request'
end
