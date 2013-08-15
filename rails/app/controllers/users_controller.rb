class UsersController < ApplicationController
  http_basic_authenticate_with :name => 'tomtuner', :password => 'thomas828'
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
end
