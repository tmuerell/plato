Rails.application.routes.draw do
  resources :users
  resources :notification_configs
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
      post :unassign
      post :watch
      post :unwatch
      post :tag
      get :link
    end
  end
  resources :customer_projects
  resources :tags
  resources :projects do
    member do
      post :select
    end
  end

  resources :ticket_ticket_relationships

  get 'dashboard/index', to: 'dashboard#index'
  get 'dashboard/profile', to: 'dashboard#profile', as: :profile
  
  ### APIs
  get 'import/ticket/:ref', to: 'import#ticket'
  post 'import/ticket', to: 'import#ticket_update'
  post 'import/tag', to: 'import#tag'
  post 'import/customer_project', to: 'import#customer_project'
  post 'import/user', to: 'import#user'
  post 'import/comment', to: 'import#comment'

  root "dashboard#index"
end
