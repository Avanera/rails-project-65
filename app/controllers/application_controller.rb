class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user
  helper_method :user_signed_in?

  def requires_authentication
    redirect_to root_path, alert: 'Requires authentication' unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    session[:user_id].present? && current_user.present?
  end
end
