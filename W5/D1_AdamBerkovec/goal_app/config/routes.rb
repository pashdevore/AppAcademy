Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :goals, only: [:create]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, only: [:new, :edit, :update, :show, :destroy]
end
