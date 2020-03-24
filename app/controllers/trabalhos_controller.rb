class TrabalhosController < ApplicationController
  skip_before_action :is_admin?, only: [:user_trabalho_params, :user_update, :create]
  helper InfoFuncionariosHelper

  def trabalhos_funcionario
    @funcionario = User.find(params[:id])
    if params[:commit] == "Relatório"
      redirect_to user_imprimivel_path(@funcionario, fim: params[:fim], inicio: params[:inicio])
    else
      periodo = params_para_data(params)
      @trabalhos = []
      ((periodo[1]-periodo[0]).to_i + 1).times do |i|
        # Ache ou crie um trabalho do usuário para a data
        if Trabalho.exists?(data: periodo[1] - i, user_id: @funcionario.id)
          query_trabalho = Trabalho.where(data: periodo[1] - i, user_id: @funcionario.id)
          query_trabalho.each do |trabalho|
            @trabalhos << trabalho
          end
        else
          @trabalhos << Trabalho.new(data: periodo[1] - i, user_id: @funcionario.id, status: "Pendente")
        end
        #@trabalhos << Trabalho.find_or_create_by(data: periodo[1] - i, user_id: @funcionario.id)
      end
    end
  end

  def create
    @trabalho = Trabalho.new(create_trabalho_params)
    if @trabalho.save
      redirect_to apontamento_path, info: "Apontamento de horas enviado para validação do gestor"
    else
      alertas = "Dados mal inseridos:"
      msgs = @trabalho.errors.full_messages
      ult_msg = msgs.pop
      msgs.each do |m|
        alertas = alertas + " " + m + ";"
      end
      alertas = alertas + " " + ult_msg
      redirect_to apontamento_path, alert: alertas
    end
  end

  def user_update
    #byebug
    @trabalho = Trabalho.find(params[:id])
    if @trabalho.update(user_trabalho_params)
      redirect_to apontamento_path, info: "Apontamento de horas enviado para validação do gestor"
    else
      alertas = "Dados mal inseridos:"
      msgs = @trabalho.errors.full_messages
      ult_msg = msgs.pop
      msgs.each do |m|
        alertas = alertas + " " + m + ";"
      end
      alertas = alertas + " " + ult_msg
      redirect_to apontamento_path, alert: alertas
    end
  end

  def recife
    @funcionarios = User.where(equipe: "Recife", ativo: true)
  end

  def paraiba
    @funcionarios = User.where(equipe: "Paraíba", ativo: true)
  end

  def admin_update
    @trabalho = Trabalho.find(params[:id])
    if @trabalho.update(admin_trabalho_params)
      redirect_to trabalhos_funcionario_path(@trabalho.user), info: "Horas extras validadas com sucesso"
      # if @trabalho.user.equipe == "Recife"
      #   redirect_to recife_path, info: "Horas extras validadas com sucesso"
      # else
      #   redirect_to paraiba_path, info: "Horas extras validadas com sucesso"
      # end
    else
      redirect_to trabalhos_funcionario_path(@trabalho.user), info: "Algo deu errado... por favor, tente de novo"
      # if @trabalho.user.equipe == "Recife"
      #   redirect_to recife_path, info: "Algo deu errado... por favor, tente de novo"
      # else
      #   redirect_to paraiba_path, info: "Algo deu errado... por favor, tente de novo"
      # end
    end
  end

  private

  def user_trabalho_params
    params.require(:trabalho).permit(:data, :entrada, :saida, :user_id, :obra_id, :veiculo_id, :sem_he)
  end

  def create_trabalho_params
    params.require(:trabalho).permit(:data, :entrada, :saida, :user_id, :obra_id, :veiculo_id, :sem_he)
  end


  def admin_trabalho_params
    params.require(:trabalho).permit(:data, :entrada, :saida, :user_id, :obra_id, :veiculo_id, :sem_he, :status)
  end
end
