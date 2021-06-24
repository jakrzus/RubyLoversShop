Rails.application.routes.draw do
  root to: 'pages#home'
  
  devise_for :admin_users
  devise_for :users
  
  namespace 'admin' do
    root to: 'pages#dashboard'
    resources :products, only: [:new, :create, :destroy, :edit, :update]
  end
  
  get 'cart', to: 'carts#show'
end
