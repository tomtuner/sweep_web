class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :current_department
  force_ssl
  before_filter :require_login, :except => [:new, :create, :destroy]
  
  private
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    
    # logger.debug @current_user.u_id
    # @current_user.formatted_u_id = @current_user.u_id.to_s.gsub(/(\d{4})(\d{3})(\d{4})/, '\1-\2-\3')
    # logger.debug @current_user.formatted_u_id + "Current"
    # @current_user
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
