Rails.application.routes.draw do
  root 'home#index'

  resource :sessions, only: :destroy
  resource :users_sessions, only: %i(new create destroy)
  resource :tenants_sessions, only: %i(new create destroy)

  resources :users, only: %i(new create destroy index)
end
