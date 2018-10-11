Rails.application.routes.draw do
  root 'welcome#index'

  resources :agents
  
end
