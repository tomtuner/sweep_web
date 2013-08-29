class AdminController < ApplicationController
  
  before_filter :check_for_admin
  
  def index
    
  end
  
  def check_for_admin
    current_user.administrator
  end
end
