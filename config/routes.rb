Rails.application.routes.draw do
  resource :sessions, only: %i(new create destroy)
end
