Rails.application.routes.draw do
  namespace :api do
    resources :articles, only: %i(index)
  end
end
