Rails.application.routes.draw do
  root 'welcome#index'
  get 'password_resets/new'
  get 'password_resets/edit'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :agents, except: [:index, :destroy]
  resources :clients
  resources :cases
  resources :comments
  resource :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :about, only: [:index]
end