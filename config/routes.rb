Rails.application.routes.draw do
  get 'cart', to: 'carts#show'
  devise_for :admin_users
  devise_for :users
  namespace 'admin' do
    root to: 'pages#dashboard'
    resources :products, only: [:new, :create, :destroy, :edit, :update]
  end
  root to: 'pages#home'
end
