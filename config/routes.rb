Rails.application.routes.draw do
  get 'stats/index'
  get 'settings', to: 'settings#index', as: 'settings_index'
  get 'help', to: 'help#index', as: 'help_index'
  get 'about', to: 'about#index', as: 'about_index'

  root 'tasks#index'
end
