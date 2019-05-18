class TrabalhosController < ApplicationController
  skip_before_action :is_admin?, only: [:user_trabalho_params, :user_update]
  helper InfoFuncionariosHelper

  def user_update
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
    @funcionarios = User.where(equipe: "Recife")
  end

  def paraiba
    @funcionarios = User.where(equipe: "Paraíba")
  end

  def admin_update
    @trabalho = Trabalho.find(params[:id])
    if @trabalho.update(admin_trabalho_params)
      if @trabalho.user.equipe == "Recife"
        redirect_to recife_path, info: "Horas extras validadas com sucesso"
      else
        redirect_to paraiba_path, info: "Horas extras validadas com sucesso"
      end
    else
      if @trabalho.user.equipe == "Recife"
        redirect_to recife_path, info: "Algo deu errado... por favor, tente de novo"
      else
        redirect_to paraiba_path, info: "Algo deu errado... por favor, tente de novo"
      end
    end
  end

  private

  def user_trabalho_params
    params.require(:trabalho).permit(:data, :entrada, :saida, :user_id, :obra_id, :veiculo_id, :sem_he)
  end

  def admin_trabalho_params
    params.require(:trabalho).permit(:status)
  end
end
