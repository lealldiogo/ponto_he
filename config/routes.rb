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

  get "relatorios", to: 'relatorios_flow#relatorios'
  get "relatorios_recife", to: 'relatorios_flow#relatorios_recife'
  get "relatorios_paraiba", to: 'relatorios_flow#relatorios_paraiba'
  get "obras_para_relatorios", to: 'relatorios_flow#obras_para_relatorios'
  get "relatorios_obra/:id", to: 'relatorios_flow#relatorios_obra', as: :relatorios_obra
  get "grupos_para_relatorios", to: 'relatorios_flow#grupos_para_relatorios'
  get "relatorios_grupo/:id", to: 'relatorios_flow#relatorios_grupo', as: :relatorios_grupo
  get "funcionarios_para_relatorios", to: 'relatorios_flow#funcionarios_para_relatorios'
  get "relatorios_funcionario/:id", to: 'relatorios_flow#relatorios_funcionario', as: :relatorios_funcionario
  get "paraiba_para_relatorios", to: 'relatorios_flow#paraiba_para_relatorios'
  get "recife_para_relatorios", to: 'relatorios_flow#recife_para_relatorios'
  get "relatorios_todos", to: 'relatorios_flow#relatorios_todos'
  get "relatorios_equipe", to: 'relatorios_flow#relatorios_equipe'

  post "admin_manual", to: 'trabalhos#admin_manual', as: :admin_manual
  post "set_trabalhos_equipes", to: 'trabalhos#set_trabalhos_equipes', as: :set_trabalhos_equipes
  post "set_trabalhos_funcionarios", to: 'trabalhos#set_trabalhos_funcionarios', as: :set_trabalhos_funcionarios

  put "admin_trabalho_recife/:id", to: 'trabalhos#admin_update_recife', as: :admin_trabalho_recife
  patch "admin_trabalho_recife/:id", to: 'trabalhos#admin_update_recife' #, as: :admin_trabalho_recife

  put "admin_trabalho_paraiba/:id", to: 'trabalhos#admin_update_paraiba', as: :admin_trabalho_paraiba
  patch "admin_trabalho_paraiba/:id", to: 'trabalhos#admin_update_paraiba' #, as: :admin_trabalho_paraiba

  get "test", to: 'pages#test'

  # Páginas usadas para baixar o relatório em excel
  get "user_relatorio/:id", to: 'relatorios#user_relatorio', as: :user_relatorio
  get "baixar_relatorio", to: 'relatorios#baixar_relatorio'

end
