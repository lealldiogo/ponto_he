class TrabalhosController < ApplicationController
  def update
    @trabalho = Trabalho.find(params[:id])
    if @trabalho.update(trabalho_params)
      redirect_to root_path, info: "Apontamento de horas enviado para validação do gestor"
    else
      alertas = "Dados mal inseridos:"
      msgs = @trabalho.errors.full_messages
      ult_msg = msgs.pop
      msgs.each do |m|
        alertas = alertas + " " + m + ";"
      end
      alertas = alertas + " " + ult_msg
      redirect_to root_path, alert: alertas
    end
  end

  private

  def trabalho_params
    params.require(:trabalho).permit(:data, :entrada, :saida, :user_id, :obra_id, :veiculo)
  end
end
