class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  protect_from_forgery
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  layout :layout_by_resource
  helper_method :current_project
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_project
    current_user.current_project
  end

  def layout_by_resource
    return false if turbo_frame_request?

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

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      t = ApiToken.find_by_token(token)
      if t
        user = t.user
        sign_in user, store: false
      end
    end
  end
end
