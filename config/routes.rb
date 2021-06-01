Rails.application.routes.draw do

  devise_for :users
  root to: 'companies#index'
  resources :companies do
    resources :comments, only: :create
  end

end