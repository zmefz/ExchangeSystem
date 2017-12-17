Rails.application.routes.draw do
  resources :users
  resources :exchanges, only: [:index, :create]
  resources :currencies, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
