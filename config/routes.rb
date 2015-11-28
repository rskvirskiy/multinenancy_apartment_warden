Rails.application.routes.draw do
  resources :users do
    collection do
      resource :sessions, only: [:new, :create, :destroy]
    end
  end
end
