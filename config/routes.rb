Rails.application.routes.draw do
  get 'post/index',to: 'posts#index'
  get 'home/show',to: 'home#show'
  root to: 'home#index'
  devise_for :users
  resources :home, only: [:index, :show]
  resources :users, only: [:index,:show,:edit,:update]
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:index,:new,:create,:show,:destroy] do
    resources :likes, only: [:create, :destroy]
  end
  get 'search' => 'search#index'
end
