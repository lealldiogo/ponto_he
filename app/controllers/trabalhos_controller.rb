class TrabalhosController < ApplicationController
  def update
    @trabalho = Trabalho.find(params[:id])
    if @trabalho.update(trabalho_params)
      redirect_to root_path, info: "Apontamento de horas enviado para validação do gestor"
    else
      render 'pages/home'
    end
  end

  private

  def trabalho_params
    params.require(:trabalho).permit(:data, :entrada, :saida, :user_id, :obra_id)
  end
end
