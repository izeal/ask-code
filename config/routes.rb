Rails.application.routes.draw do

  root 'users#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :posts do
    resources :comments
  end
  resources :hashtags, only: [:show] do
    get "posts"
  end
end
