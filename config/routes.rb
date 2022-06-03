Rails.application.routes.draw do
  resources :tasks
  post 'toggle', to: 'locales#toggle'

  namespace :admin do
    resources :users
    root 'users#index'
  end

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :users, only: [:index, :edit, :update]
  resources :tasks do
    resources :items
  end

  get 'users', to: 'users#index', as: 'users_index'
  get 'settings', to: 'settings#index', as: 'settings_index'
  get 'help', to: 'help#index', as: 'help_index'
  get 'about', to: 'about#index', as: 'about_index'
  get 'stats', to: 'stats#index', as: 'stats_index'

  # scope '/:locale' do
  #   get 'about', to: 'about#index'
  # end

  root 'tasks#index'
end
