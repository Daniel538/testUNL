Rails.application.routes.draw do
  devise_for :users
  root 'projects#index', as: 'home'

  resources :projects do
    resources :tasks
  end

  resources :tasks do
    resources :comments
  end

  resources :comments do
    resources :comments
  end
end
