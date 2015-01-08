Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests
  resource :user
  resource :session
  resources :login, only: [:index]

  delete 'login' => 'login#destroy'

  post 'rental/:id/' => 'cat_rental_requests#approve_or_deny'
end
