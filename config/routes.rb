Rails.application.routes.draw do
  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  else
    devise_for :users
  end
  resources :comments
  resources :tickets
  resources :customer_projects
  resources :tags
  resources :projects
  get 'dashboard/index'

  root "dashboard#index"
end
