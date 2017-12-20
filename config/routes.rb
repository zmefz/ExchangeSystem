Rails.application.routes.draw do
  resources :users
  resources :exchanges, only: [:show, :index, :create]
  resources :currencies, only: [:index]
  resources :sessions, only: [:show]
end
