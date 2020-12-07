Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :tasks
  resources :users, except: [:index]
  resources :sessions, only: %i[new create destroy]
  namespace :admin do
    resources :users
  end
end
