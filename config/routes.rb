Rails.application.routes.draw do
  get 'settings', to: 'settings#index', as: 'settings_index'
  get 'help', to: 'help#index', as: 'help_index'
  get 'about', to: 'about#index', as: 'about_index'
  get 'stats', to: 'stats#index', as: 'stats_index'

  root 'tasks#index'
end
