# frozen_string_literal: true

require 'resque/server'

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # devise_for :users, ActiveAdmin::Devise.config
  devise_for :users

  # devise_for :admin_users, ActiveAdmin::Devise.config
  # devise_for :admin_users, ActiveAdmin::Devise.config
  mount RootApi => '/'
  mount Resque::Server.new, at: '/resque'

  post 'toggle', to: 'locales#toggle'

  # namespace :admin do
  #   resources :abouts, only: [:edit, :index, :show, :update]
  #   resources :users do
  #     member do
  #       post :toggle, action: :toggle
  #     end
  #   end
  #   root 'users#index'
  # end

  # devise_for :users do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end

  resources :users, only: %i[index edit update]
  resources :tasks do
    resources :items
  end

  get 'users', to: 'users#index', as: 'users_index'
  get 'settings', to: 'settings#index', as: 'settings_index'
  get 'help', to: 'help#index', as: 'help_index'
  get 'about', to: 'about#index', as: 'about_index'
  get 'stats', to: 'stats#index', as: 'stats_index'


  root 'tasks#index'
end
