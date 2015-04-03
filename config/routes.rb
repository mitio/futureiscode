Rails.application.routes.draw do
  devise_for :schools
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
end
