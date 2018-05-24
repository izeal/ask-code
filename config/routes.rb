Rails.application.routes.draw do

  root 'users#index'

  resources :users
  resource :sessions, only: [:new, :create, :destroy]
  resources :posts do
    resources :comments
  end
  resources :hashtags, only: [:show] do
    get "posts"
  end

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
end
