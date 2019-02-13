class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :is_admin?
  add_flash_types(:warning, :info)


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
