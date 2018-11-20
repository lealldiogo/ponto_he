class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:test]

  def home
    # Opção 1: find_or_create_by
    @trabalhos = []
    3.times do |i|
      # Ache ou crie um trabalho do usuário para a data
      @trabalhos << Trabalho.find_or_create_by(data: Date.today - i, user_id: current_user.id)
    end

    # Checar quais alertas (? precisa ?)
  end

  def test
    flash[:warning] = "WARNING"
    flash[:alert] = "ALERT"
    flash[:notice] = "NOTICE"
    flash[:info] = "INFO"
  end

  def admin
  end
end
