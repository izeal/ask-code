Rails.application.routes.draw do

  root 'users#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
end
