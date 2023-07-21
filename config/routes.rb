Rails.application.routes.draw do
  resources :comments
  resources :tickets
  resources :customer_projects
  resources :tags
  resources :projects
  get 'dashboard/index'

  root "dashboard#index"
end
