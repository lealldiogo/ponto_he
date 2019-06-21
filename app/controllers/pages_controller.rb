class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:test, :home]
  skip_before_action :is_admin?, only: [:apontamento, :test, :home]

  def apontamento
    if current_user.admin?
      redirect_to admin_path
    else
      periodo = params_para_data(params)
      # Opção 1: find_or_create_by
      @trabalhos = []
      ((periodo[1]-periodo[0]).to_i + 1).times do |i|
        # Ache ou crie um trabalho do usuário para a data
        @trabalhos << Trabalho.find_or_create_by(data: periodo[1] - i, user_id: current_user.id)
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

  def relatorios

  end

  def relatorios_recife

  end

  def relatorios_paraiba

  end

  def relatorios_obra
    @obra = Obra.find(params[:id])
  end

  def obras_para_relatorios
    @obras = Obra.all
  end


end
