Rails.application.routes.draw do
  root "static_pages#show", page: "home"
  get "/pages/*page", to: "static_pages#show"
  get "/cart", to: "cart#index"

  namespace :admin do
    root "dashboard#show"
    resources :users
    resources :categories
    resources :products
  end

  resources :products
  resources :users, except: [:destroy]
  devise_for :users
end
