class GruposController < ApplicationController

  def new
    @grupo = Grupo.new
  end

  def index
    @grupos = Grupo.all
  end

  def show
    @grupo = Grupo.find(params[:id])
  end

  def edit
    @grupo = Grupo.find(params[:id])
  end

  def create
    @grupo = Grupo.new(grupo_params)
    if @grupo.save
      redirect_to grupos_path
    else
      render :new
    end
  end

  def update
    @grupo = Grupo.find(params[:id])
    if @grupo.update(grupo_params)
      redirect_to grupos_path
    else
      render :edit
    end
  end

  def destroy
    @grupo = Grupo.find(params[:id])
    @grupo.destroy
    redirect_to grupos_path
  end

  private

  def grupo_params
    params.require(:grupo).permit(:nome, :valor_he_exce, :inicio_exce, :fim_exce, :inicio_antigo, :fim_antigo, user_ids: [])
  end

end
