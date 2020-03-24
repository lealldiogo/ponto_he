class UsersController < ApplicationController
  before_action :allow_without_password, only: [:update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def cadastros
    @users = User.where(ativo: true)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to cadastros_path, notice: "Usuário criado com sucesso"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to cadastros_path, notice: "Informações alteradas com sucesso"
    else
      render :edit
    end
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to cadastros_path
  # end

  private

  def user_params
    params.require(:user).permit(:username, :nome_completo, :salario, :apelido, :cargo, :equipe, :password, :admin, :ativo)
  end

  def allow_without_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

end
