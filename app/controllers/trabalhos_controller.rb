class TrabalhosController < ApplicationController
  def create
    @trabalho = Trabalho.new(trabalho_params)
    if @trabalho.save
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  private

  def trabalho_params
    params.require(:trabalho).permit(:data, :entrada, :saida, :user_id, :obra_id)
  end
end
