Rails.application.routes.draw do
  root 'dashboard#index', as: :dashboards

  resource :registration, only: [:new, :create]
  resource :logins, only: [:new, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
