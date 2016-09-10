Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'
    resources :users
    resources :chatrooms, only: [:destroy]
  end

  devise_for :users, controllers: { registrations: :registrations }
  mount ActionCable.server => '/cable'
  resources :chatrooms, only: [:index, :show, :new, :create]
  resources :messages, only: [:index, :new, :create]
  get 'profile', to: 'users#show'

  root to: 'dashboard#index'
end
