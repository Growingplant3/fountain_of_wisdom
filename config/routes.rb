Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :users, except: [:index]
end
