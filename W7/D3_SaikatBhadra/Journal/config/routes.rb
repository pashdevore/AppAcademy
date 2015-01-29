Rails.application.routes.draw do
    root "static_pages#root"

    resources :posts, only: [:create, :update, :destroy, :show, :index]
end
