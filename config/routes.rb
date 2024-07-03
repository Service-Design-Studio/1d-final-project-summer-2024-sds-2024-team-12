Rails.application.routes.draw do

  get 'scheduled_transactions/new'
  post 'scheduled_transactions/create'
  get 'pay_and_transfer_page/index'
  get 'paynow/index'
  resources :shortcut_buttons, only: [:new, :create, :destroy ]
  resources :scheduled_transactions, only: [:new, :create,]
  resources :transactions, only: [:index, :show, :new, :create, :edit, :update, :destroy]



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "transactions#index"
end


