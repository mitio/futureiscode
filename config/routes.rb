Rails.application.routes.draw do
  root to: 'home#index'

  resources :contacts, only: :index

  as :school do
    get 'schools/profile', to: 'devise/registrations#edit', as: :school_root
  end

  devise_for :schools
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
