class UsersController < ApplicationController
  http_basic_authenticate_with :name => 'SweepEvents', :password => 'SweepEvents9', except: [:update]
  def new
    @user = User.new
    @customers = Customer.all
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "Signed Up!"
    else
      @customers = Customer.all
      render "new"
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_url, :notice => 'Password Successfully Updated' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
