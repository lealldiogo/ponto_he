class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :is_admin?
  add_flash_types(:warning, :info)

  def params_para_data(params_array)
    periodo = []
    if params[:inicio].blank? || params[:fim].blank?
      fim = Date.today
      inicio = Date.today - 7
    else
      fim = Date.strptime(params[:fim], "%d/%m/%Y")
      inicio = Date.strptime(params[:inicio], "%d/%m/%Y")
      if inicio > fim
        fim = Date.today
        inicio = Date.today - 7
      end
      # fim = params_para_data(params[:fim])
      # inicio = params_para_data(params[:inicio])
    end
    periodo[0] = inicio
    periodo[1] = fim
    return periodo
    # date_array = []
    # date_hash.each_pair { |k,v| date_array << v}
    # return Date.new(date_array[2].to_i, date_array[1].to_i, date_array[0].to_i)
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_path
    else
      apontamento_path
    end
  end

  private

  def is_admin?
    unless current_user.admin?
      redirect_to apontamento_path, alert: "Você não tem autorização para acessar esta página"
    end
  end
end
