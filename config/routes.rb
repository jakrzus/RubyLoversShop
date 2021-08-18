Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :admin_users
  devise_for :users

  namespace 'admin' do
    root to: 'pages#dashboard'
    resources :products, only: %i[new create destroy edit update]
    resources :orders, only: %i[index show]
    resources :payments, only: :update
    resources :shipments, only: :update
    resources :order_statuses, only: :update
  end

  resources :products, only: [:show]

  get 'cart', to: 'carts#show'
  post 'cart', to: 'carts#checkout'
  delete 'cart', to: 'carts#destroy'
  post 'add_product/:id', to: 'carts#add_product', as: 'add_product'

  resources :check_outs, only: [:new]
  resources :cart_items, only: [:update]
end
