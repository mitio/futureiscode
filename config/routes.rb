Rails.application.routes.draw do
  root to: 'home#index'

  resources :contacts, only: :index
  resources :participating_schools, path: 'participating-schools'
  resources :companies
  resources :events do
    collection do
      get :map
    end
    member do
      post :approve
      post :unapprove
    end
  end
  resources :frequently_asked_questions, path: 'frequently-asked-questions'

  as :school do
    get 'schools/profile', to: 'devise/registrations#edit', as: :school_root
  end

  as :speaker do
    get 'speakers/profile', to: 'devise/registrations#edit', as: :speaker_root
  end

  devise_for :schools, controllers: {registrations: 'registrations'}
  devise_for :speakers, controllers: {registrations: 'registrations'}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
