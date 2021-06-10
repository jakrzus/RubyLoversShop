Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users
  namespace 'admin' do
    root to: 'pages#dashboard'
    resources :products, only: [:new, :create]
  end
  root to: 'pages#home'
end
