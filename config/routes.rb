Rails.application.routes.draw do
  root to: 'pages#home'
  
  devise_for :admin_users
  devise_for :users
  
  namespace 'admin' do
    root to: 'pages#dashboard'
    resources :products, only: [:new, :create, :destroy, :edit, :update]
  end
  
  resources :products, only: [:show]
  
  get 'cart', to: 'carts#show'
  post 'cart', to: 'carts#checkout'
  delete 'cart', to: 'carts#destroy'
  post 'add_product/:id', to: 'carts#add_product', as: 'add_product'
end
