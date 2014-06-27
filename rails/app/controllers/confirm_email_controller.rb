class ConfirmEmailController < ApplicationController
  skip_before_filter :require_login, :only => [:show]
  def show
    user = User.find_by_auth_token(params[:id])
    if user
      if !user.email_conf
        user.email_conf = true
        user.save
      else
        redirect_to root_path
      end
    else
      
    end
    
  end
end
