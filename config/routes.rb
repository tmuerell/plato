Rails.application.routes.draw do
  get 'dashboard/index'

  root "dashboard#index"
end
