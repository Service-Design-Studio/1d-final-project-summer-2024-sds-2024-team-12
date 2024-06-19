Rails.application.routes.draw do
  root 'home#index'
  get 'login', to: 'sessions#new'
  resources :transactions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "transactions#index"
end
