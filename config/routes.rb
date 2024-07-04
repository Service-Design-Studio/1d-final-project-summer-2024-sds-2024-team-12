Rails.application.routes.draw do

  get 'scheduled_transactions/new'
  post 'scheduled_transactions/create'
  get 'pay_and_transfer_page/index'
  get 'paynow/index'
  resources :shortcut_buttons, only: [:new, :create, :destroy ]
  resources :scheduled_transactions, only: [:new, :create,]
  resources :transactions, only: [:index, :show, :new, :create, :edit, :update, :destroy]



  get 'overseas_transfer', to: 'overseas#overseas_transfer'
  get 'overseas_transfer/select_location', to: 'overseas#select_location'
  get 'overseas_transfer/new_recipient', to: 'overseas#new_recipient'
  post 'overseas_transfer/create_recipient', to: 'overseas#create_recipient'
  get 'overseas_transfer/confirmation', to: 'overseas#confirmation'
  get 'overseas_transfer/make_transfer', to: 'overseas#make_transfer'
  # Ensure all routes are prefixed with 'overseas_transfer' and point to 'overseas#action'


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


