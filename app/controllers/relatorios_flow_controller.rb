class RelatoriosFlowController < ApplicationController

  def user_relatorio
    @user = User.find(params[:id])
  end

  def relatorios_obra
    @obra = Obra.find(params[:id])
  end

  def obras_para_relatorios
    @obras = Obra.all
  end

  def relatorios_grupo
    @grupo = Grupo.find(params[:id])
  end

  def grupos_para_relatorios
    @grupos = Grupo.all
  end

  def relatorios_funcionario
    @funcionario = User.find(params[:id])
  end

  def funcionarios_para_relatorios
    @funcionarios = User.where(admin: false)
  end

  def relatorios_equipe

  end

  def relatorios_todos

  end

  def recife_para_relatorios
    @funcionarios = User.where(admin: false, equipe: "Recife")
  end

  def paraiba_para_relatorios
    @funcionarios = User.where(admin: false, equipe: "Paraíba")
  end

  def relatorios

  end

  def relatorios_recife

  end

  def relatorios_paraiba

  end

end
