Rails.application.routes.draw do
  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  else
    devise_for :users
  end
  resources :comments
  resources :boards
  resources :tickets do
    collection do
      get :inbox
      get :backlog
    end
    member do
      post :approve
      post :mine
      post :tag
    end
  end
  resources :customer_projects
  resources :tags
  resources :projects do
    member do
      post :select
    end
  end

  get 'dashboard/index', to: 'dashboard#index'
  get 'dashboard/profile', to: 'dashboard#profile', as: :profile

  root "dashboard#index"
end
