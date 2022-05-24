Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :users, only: [:index, :edit, :update]

  get 'users', to: 'users#index', as: 'users_index'
  get 'settings', to: 'settings#index', as: 'settings_index'
  get 'help', to: 'help#index', as: 'help_index'
  get 'about', to: 'about#index', as: 'about_index'
  get 'stats', to: 'stats#index', as: 'stats_index'

  root 'tasks#index'
end
