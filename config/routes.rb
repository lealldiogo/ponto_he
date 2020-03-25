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

  get "equipes", to: 'pages#equipes'
  get "recife", to: 'trabalhos#recife'
  get "paraiba", to: 'trabalhos#paraiba'

  get "trabalhos_funcionario/:id", to: 'trabalhos#trabalhos_funcionario', as: :trabalhos_funcionario

  get "user_imprimivel/:id", to: 'relatorios#user_imprimivel', as: :user_imprimivel
  get "equipe_obra_imprimivel", to: 'relatorios#equipe_obra_imprimivel'

  get "relatorios", to: 'pages#relatorios'
  get "relatorios_recife", to: 'pages#relatorios_recife'
  get "relatorios_paraiba", to: 'pages#relatorios_paraiba'
  get "obras_para_relatorios", to: 'pages#obras_para_relatorios'
  get "relatorios_obra/:id", to: 'pages#relatorios_obra', as: :relatorios_obra
  get "grupos_para_relatorios", to: 'pages#grupos_para_relatorios'
  get "relatorios_grupo/:id", to: 'pages#relatorios_grupo', as: :relatorios_grupo
  get "funcionarios_para_relatorios", to: 'pages#funcionarios_para_relatorios'
  get "relatorios_funcionario/:id", to: 'pages#relatorios_funcionario', as: :relatorios_funcionario

  get "user_relatorio/:id", to: 'relatorios#user_relatorio', as: :user_relatorio
  get "baixar_relatorio", to: 'relatorios#baixar_relatorio'

  get "test", to: 'pages#test'
end
