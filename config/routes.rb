Rails.application.routes.draw do
  root 'home#index'

  resource :sessions, only: %i(new create destroy)
  resources :users, only: %i(new create destroy index)
end
