Rails.application.routes.draw do
  root to: 'home#index'

  resources :contacts, only: :index

  devise_for :schools
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
