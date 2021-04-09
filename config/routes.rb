Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :polls, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :receivers, only: [ :new, :create ]
  end
  resources :receivers, only: [:edit, :update, :destroy]
end
