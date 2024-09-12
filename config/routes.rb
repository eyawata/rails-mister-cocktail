Rails.application.routes.draw do
  root to: 'cocktails#index'

  resources :cocktails, only: [:index, :show, :edit, :new, :create]
  resources :doses, only: [:new, :create, :destroy]
end
