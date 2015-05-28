Rails.application.routes.draw do
  root 'users#logout'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#sign_in'
  post 'users/logout', to: 'users#logout'
  resources :users
end
