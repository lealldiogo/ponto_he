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

  def create
    @grupo = Grupo.new(grupo_params)
    params[:grupo][:users].each do |u|
      if u.present?
        @grupo.user_id = u
      end
    end
    if @grupo.save
      redirect_to grupos_path
    else
      render :new
    end
  end

  private

  def grupo_params
    params.require(:grupo).permit(:nome, :users)
  end
end
