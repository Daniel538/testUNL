Rails.application.routes.draw do
  devise_for :users
  root 'projects#index', as: 'home'

  resources :projects do
    resources :tasks
  end
end
