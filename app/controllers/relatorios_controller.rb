class RelatoriosController < ApplicationController
  helper RelatoriosHelper
  layout "imprimivel"

  def user_imprimivel
    @periodo = params_para_data(params)
    @funcionario = User.find(params[:id])
  end

  def equipe_obra_imprimivel
    # Os trabalhos ainda não estão sendo filtrados por data
    @periodo = params_para_data(params)
    case params[:cabecalho]
    when "PB"
      @funcionarios = User.where(equipe: "Paraíba").joins(:trabalhos).where(trabalhos: {sem_he: false}).where.not(trabalhos: {status: "Pendente"}).distinct
      @cabecalho = params[:cabecalho]
    when "REC"
      @funcionarios = User.where(equipe: "Recife").joins(:trabalhos).where(trabalhos: {sem_he: false}).where.not(trabalhos: {status: "Pendente"}).distinct
      @cabecalho = params[:cabecalho]
    else
      @obra = Obra.find(params[:cabecalho])
      @cabecalho = @obra.nome
      @funcionarios = User.joins(:trabalhos).where(trabalhos: {obra_id: @obra.id}).distinct
    end
  end

  def user_relatorio
    @user = User.find(params[:id])
  end

  def baixar_relatorio
    @user = User.find(params[:user_id])
    dates = gerar_array_de_datas(params)
    @trabalhos = []
    dates.each do |date|
      @trabalhos << Trabalho.find_or_create_by(data: date, user_id: @user.id)
    end
    fname = nome_do_arquivo(@user, @trabalhos)
    render xlsx: "relatorios/baixar_relatorio", formats: [:xlsx], filename: fname
    # respond_to do |format|
    #   format.xlsx {render xlsx: "relatorios/baixar_relatorio", filename: "trabalhos.xlsx"}
    # end
  end

  def nome_do_arquivo(user, trabalhos)
    nome_do_arquivo = trabalhos.last.data.strftime("%d-%m") + "_a_" + trabalhos.first.data.strftime("%d-%m") + "_" + user.username.gsub(/\./, '_') + ".xlsx"
  end

  def gerar_array_de_datas(parametros)
    case parametros[:trabalho]["data(2i)"]
    when "1"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 1, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 1, 31))
    when "2"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 2, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 2, 28))
    when "3"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 3, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 3, 31))
    when "4"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 4, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 4, 30))
    when "5"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 5, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 5, 31))
    when "6"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 6, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 6, 30))
    when "7"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 7, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 7, 31))
    when "8"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 8, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 8, 31))
    when "9"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 9, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 9, 30))
    when "10"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 10, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 10, 31))
    when "11"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 11, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 11, 30))
    when "12"
      dates = (Date.new(parametros[:trabalho]["data(1i)"].to_i, 12, 1)..Date.new(parametros[:trabalho]["data(1i)"].to_i, 12, 31))
    end
  end

end
