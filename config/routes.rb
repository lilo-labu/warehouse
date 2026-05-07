Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root "warehouses#index", as: :authenticated_root
  end

  root "pages#home"

  get "offer",    to: "pages#offer"
  get "opening",  to: "pages#opening"

  resources :warehouses
  resources :categories, except: [:show]
  resources :products
  resources :stock_movements, only: [:index, :new, :create]
end
