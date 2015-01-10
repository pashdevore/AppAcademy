Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, only: [:new, :create, :index, :show, :update, :edit] do
    resources :posts, only:[:new, :create]
  end
  resources :posts, only: [:show, :edit, :update]
end
