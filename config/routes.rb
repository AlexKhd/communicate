Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :chatrooms, param: :slug
  resources :messages
  get 'dashboard/index'

  root to: 'dashboard#index'
end
