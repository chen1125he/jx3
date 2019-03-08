# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'admin/dashboards#index'
  namespace :admin do
    root to: 'dashboards#index'
    # Authentication
    get 'login', to: 'sessions#new', as: :login
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy', as: :logout

    resources :dashboards, only: [:index]
    resources :charts
    resources :categories, only: [:index]
    resources :areas, only: [:index]
    resources :services, only: [:index]
    resources :products, only: %i[index edit update] do
      resources :history_prices
    end
    resources :topping_products, only: [:update]
    resources :bulk_import_history_prices, only: %i[new create]
    resource :generate_history_price_csvs, only: %i[create]

    resources :materials, only: [:index]
  end

  resources :jobs, only: [:show], param: :jid
  resource :download_file, only: [:create]
end
