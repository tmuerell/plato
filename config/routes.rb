Rails.application.routes.draw do
  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  else
    devise_for :users
  end
  resources :comments
  resources :tickets do
    collection do
      get :inbox
      get '/board/:id', to: 'tickets#board'
    end
    member do
      post :mine
      post :move
    end
  end
  resources :customer_projects
  resources :tags
  resources :projects do
    member do
      post :select
    end
  end
  get 'dashboard/index'

  root "dashboard#index"
end
