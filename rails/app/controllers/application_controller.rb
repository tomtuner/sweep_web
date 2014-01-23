class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :current_department
  force_ssl
  before_filter :require_login, :except => [:new, :create, :destroy]
  
  private
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  def current_department
    @current_dept ||= Department.find_by_valid_key!(cookies[:valid_key]) if cookies[:valid_key]
  end
  
  def require_login
    unless current_user || current_department
      redirect_to log_in_url
    end
  end
end
