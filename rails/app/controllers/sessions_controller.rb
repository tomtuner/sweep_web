class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    department = Department.find_by_valid_key(params[:valid_key])
    if user
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      
      redirect_to root_url, :notice => "Logged In!"
    elsif department
      if params[:remember_me]
        cookies.permanent[:valid_key] = department.valid_key
      else
        cookies[:valid_key] = department.valid_key
      end
      redirect_to root_url, :notice => "Logged In!"
      
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    cookies.delete(:valid_key)
    redirect_to root_path, :notice => "Logged Out!"
  end
end
