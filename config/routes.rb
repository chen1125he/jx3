# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'admin/dashboards#index'
  namespace :admin do
    resources :dashboards
    resources :categories
    resources :areas
  end
end
