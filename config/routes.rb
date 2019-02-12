# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'admin/dashboards#index'
  namespace :admin do
    resources :dashboards
    resources :categories
    resources :areas
    resources :services
    resources :products do
      resources :requirements, only: %i[new create edit update destroy]
      resources :system_prices, only: %i[new create edit update destroy]
      resources :history_prices
    end
    resources :bulk_import_products, only: %i[new create]

    resources :materials, only: [:index]
  end
end
