Rails.application.routes.draw do
  resources :interactions
  resources :projects
  resources :customers
  resources :reports
  devise_for :users
  root 'home#index'
  get "up" => "rails/health#show", as: :rails_health_check
end
