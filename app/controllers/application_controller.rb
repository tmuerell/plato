class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  layout :layout_by_resource
  helper_method :current_project
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_project
    current_user.current_project
  end

  def layout_by_resource
    if devise_controller?
      "nosession"
    else
      "application"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
  end

end
