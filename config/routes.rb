Rails.application.routes.draw do
  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  else
    devise_for :users
  end
  resources :user_project_roles
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
  
  ### APIs
  get 'import/ticket/:ref', to: 'import#ticket'
  post 'import/ticket', to: 'import#ticket_update'
  post 'import/tag', to: 'import#tag'
  post 'import/customer_project', to: 'import#customer_project'
  post 'import/user', to: 'import#user'
  post 'import/comment', to: 'import#comment'

  root "dashboard#index"
end
