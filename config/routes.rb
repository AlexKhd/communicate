Rails.application.routes.draw do
  namespace :admin do
    root 'dashboard#index'
    resources :users
  end

  devise_for :users
  mount ActionCable.server => '/cable'
  resources :chatrooms, param: :slug
  resources :messages
  # get 'dashboard/index'
  get 'profile', to: 'users#show'

  root to: 'dashboard#index'
end
