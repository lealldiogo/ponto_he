class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  add_flash_types(:warning, :info)


  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_path
    else
      root_path
    end
  end
end
