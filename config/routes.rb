Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", confirmations: "users/confirmations", passwords: "users/passwords", registrations: "users/registrations", unlocks: "users/unlocks" }
  root to: 'pages#home'
  resources :trabalhos, except: [:update]
  resources :users
  resources :grupos
  resources :obras
  resources :veiculos

  get "apontamento", to: 'pages#apontamento'

  put "user_trabalho/:id", to: 'trabalhos#user_update', as: :user_trabalho
  patch "user_trabalho/:id", to: 'trabalhos#user_update'

  put "admin_trabalho/:id", to: 'trabalhos#admin_update', as: :admin_trabalho
  patch "admin_trabalho/:id", to: 'trabalhos#admin_update' #, as: :admin_trabalho

  get "admin", to: 'pages#admin'
  get "cadastros", to: 'users#cadastros'

  get "recife", to: 'trabalhos#recife'
  get "paraiba", to: 'trabalhos#paraiba'

  get "user_relatorio/:id", to: 'relatorios#user_relatorio', as: :user_relatorio
  get "relatorios", to: 'relatorios#relatorios'
  get "baixar_relatorio", to: 'relatorios#baixar_relatorio'

  get "recife_imprimivel", to: 'relatorios#recife_imprimivel'
  get "relatorios_recife", to: 'relatorios#relatorios_recife'
  get "paraiba_imprimivel", to: 'relatorios#paraiba_imprimivel'
  get "relatorios_paraiba", to: 'relatorios#relatorios_paraiba'

  get "test", to: 'pages#test'
end
