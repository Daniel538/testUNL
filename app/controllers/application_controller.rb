class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def is_admin
    unless current_user.admin?
      redirect_to home_path, alert: "You do not have permissions for this action"
    end
  end
end
