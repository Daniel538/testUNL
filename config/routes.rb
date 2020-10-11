Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root "projects#index", as: :home
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_home
    end
  end
  # root "projects#index", as: "home"

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
