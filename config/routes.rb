Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'
    resources :users
    resources :chatrooms, only: [:destroy]
    resources :audits, only: [:destroy, :index]
  end

  namespace :api, defaults:{format: 'json'} do
    resources :pictures
  end

  get "/posts/:id", to: "folders#show", as: 'post'

  devise_for :users, controllers: { registrations: :registrations, omniauth_callbacks: 'users/omniauth_callbacks' }
  mount ActionCable.server => '/cable'
  resources :chatrooms, only: [:index, :show, :new, :create]
  resources :messages, only: [:index, :new, :create]
  get 'profile', to: 'users#show'
  resources :pictures, only: [:index, :create, :destroy]

  root to: 'dashboard#index'
end
