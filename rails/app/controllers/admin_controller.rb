class AdminController < ApplicationController
  
  before_filter :check_for_admin
  
  def index
    @departments = Department.find_all_by_customer_id(current_user[:customer_id])    
  end
  
  def check_for_admin
    current_user.administrator
  end
end
