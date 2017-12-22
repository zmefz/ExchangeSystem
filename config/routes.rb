Rails.application.routes.draw do
  resources :questions, only: [:index, :create, :destroy]
  resources :users
  resources :exchanges, only: [:show, :index, :create]
  resources :currencies, only: [:index]
  resources :sessions, only: [:create, :destroy]
end
