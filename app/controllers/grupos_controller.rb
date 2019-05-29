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
    #byebug
    #params[:grupo][:users].each do |u|
    #  if u.present?
    #    @grupo.users << User.find(u.to_i)
    #  end
    #end
    if @grupo.save
      redirect_to grupos_path
    else
      render :new
    end
  end

  private

  def grupo_params
    params.require(:grupo).permit(:nome, :user_ids) #:membros_attibutes => [:grupo_id, :user_id])
  end

  def membro_params
    params.require(:grupo).permit(:nome, :user_ids)
  end
end
