# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'members#index'
  resources :members, only: %i[index show create]
  get '/members/:id/search/:query', to: 'members#search'
end
