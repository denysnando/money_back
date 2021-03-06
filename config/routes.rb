# frozen_string_literal: true

Rails.application.routes.draw do
  get :admin, to: 'welcomes#index', path: 'admin'
  get :homepage, to: 'homepage#index', path: '/'

  devise_for :users, controllers: { registrations: 'users' }
  resources :users
  resources :offers do
    collection do
      put :change_status
    end
  end
end
