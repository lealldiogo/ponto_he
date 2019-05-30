class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:test, :home]
  skip_before_action :is_admin?, only: [:apontamento, :test, :home]

  def apontamento
    if current_user.admin?
      redirect_to admin_path
    else
      if params[:inicio].nil? || params[:fim].nil?
        fim = Date.today
        inicio = Date.today - 7
      else
        inicio = Date.strptime(params[:inicio], "%d/%m/%Y")
        fim = Date.strptime(params[:fim], "%d/%m/%Y")
        # fim = params_para_data(params[:fim])
        # inicio = params_para_data(params[:inicio])
      end
      # Opção 1: find_or_create_by
      @trabalhos = []
      ((fim-inicio).to_i + 1).times do |i|
        # Ache ou crie um trabalho do usuário para a data
        @trabalhos << Trabalho.find_or_create_by(data: fim - i, user_id: current_user.id)
      end
      # Checar quais alertas (? precisa ?)
    end
  end

  def home

  end

  def test
    flash[:warning] = "WARNING"
    flash[:alert] = "ALERT"
    flash[:notice] = "NOTICE"
    flash[:info] = "INFO"
  end

  def admin
  end
end
