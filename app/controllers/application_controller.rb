class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin
    authenticate_user!

    if current_user.admin == nil
      raise StandardError.new 'Access denied.'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :login
  end
end
