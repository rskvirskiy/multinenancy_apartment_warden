Rails.application.routes.draw do
  root 'home#index'

  resources :tenants do
    collection do
      resource :sessions, only: [:new, :create, :destroy]
    end
  end
end
