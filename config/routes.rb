Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", confirmations: "users/confirmations", passwords: "users/passwords", registrations: "users/registrations", unlocks: "users/unlocks" }
  root to: 'pages#home'
  resources :trabalhos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "admin", to: 'pages#admin'

  get "test", to: 'pages#test'
end
