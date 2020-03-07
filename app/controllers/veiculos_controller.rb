class VeiculosController < ApplicationController
  def new
    @veiculo = Veiculo.new
  end

  def index
    @veiculos = Veiculo.all
  end

  def show
    @veiculo = Veiculo.find(params[:id])
  end

  def edit
    @veiculo = Veiculo.find(params[:id])
  end

  def create
    @veiculo = Veiculo.new(veiculo_params)
    if @veiculo.save
      redirect_to veiculos_path
    else
      render :new
    end
  end

  def update
    @veiculo = Veiculo.find(params[:id])
    if @veiculo.update(veiculo_params)
      redirect_to veiculos_path
    else
      render :edit
    end
  end

  def destroy
    @veiculo = Veiculo.find(params[:id])
    @veiculo.destroy
    redirect_to veiculos_path
  end


  private

  def veiculo_params
    params.require(:veiculo).permit(:nome)
  end
end
