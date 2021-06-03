Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users
  root to: 'pages#home'
end
