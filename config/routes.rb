Rails.application.routes.draw do

  devise_for :users
  root to: 'companies#index'
  resources :companies, only: [:new, :create, :show, :edit, :update]

end