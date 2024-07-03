Rails.application.routes.draw do

  get 'scheduled_transactions/new'
  post 'scheduled_transactions/create'

  resources :transactions
  resources :shortcut_buttons, only: [:new, :create, :destroy ]
  resources :scheduled_transactions, only: [:new, :create,]

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  root to: "main#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "transactions#index"
end
