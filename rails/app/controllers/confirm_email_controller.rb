class ConfirmEmailController < ApplicationController
  skip_before_filter :require_login, :only => [:show]
  def show
    user = User.find_by_auth_token(params[:id])
    if user
      user.email_conf = true
      user.save
      redirect_to root_path
    else
      
    end
    
  end
end
