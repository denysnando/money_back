Rails.application.routes.draw do
  get :admin, to: 'welcomes#index', path: 'admin'

  devise_for :users, :controllers => { registrations: 'users' }
  resources :users
end
