# frozen_string_literal: true

Rails.application.routes.draw do
  get 'events/index'
  get 'events/create'
  root to: 'events#index'
  resources :events, only: %i[index create edit update]
end
