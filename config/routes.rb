# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'admin/dashboards#index'
  namespace :admin do
    resources :dashboards, only: [:index]
    resources :charts
    resources :categories, only: [:index]
    resources :areas, only: [:index]
    resources :services, only: [:index]
    resources :products, only: %i[index edit update] do
      resources :history_prices
    end
    resources :topping_products, only: [:update]
    resources :bulk_import_products, only: %i[new create]
    resource :generate_product_csvs, only: %i[create]

    resources :materials, only: [:index]
  end

  resources :jobs, only: [:show], param: :jid
  resource :download_file, only: [:create]
end
