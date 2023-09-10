Rails.application.routes.draw do
  resources :project_group_mappings
  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  else
    devise_for :users
  end
  get 'reports/sla', as: :sla_report
  resources :tag_groups do
    member do
      get :ticket_form
    end
  end
  resources :notification_configs
  resources :users
  resources :user_project_roles
  resources :comments
  resources :boards
  resources :tickets do
    member do
      get :transitions
    end
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
  resources :tags
  resources :projects do
    member do
      post :select
    end
  end

  resources :ticket_ticket_relationships

  get 'dashboard/index', to: 'dashboard#index'
  get 'dashboard/profile', to: 'dashboard#profile', as: :profile

  get 'search', to: 'search#search', as: :search

  ### APIs
  get 'import/ticket/:ref', to: 'import#ticket'
  post 'import/ticket', to: 'import#ticket_update'
  post 'import/tag', to: 'import#tag'
  post 'import/customer_project', to: 'import#customer_project'
  post 'import/user', to: 'import#user'
  post 'import/comment', to: 'import#comment'

  root "dashboard#index"
end
