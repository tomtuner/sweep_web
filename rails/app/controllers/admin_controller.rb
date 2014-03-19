# require 'qr4r'

class AdminController < ApplicationController
  
  before_filter :check_for_admin
  
  def index
    @departments = Department.find_all_by_customer_id(current_user[:customer_id])    
    @advisors = Advisor.find_all_by_customer_id(current_user[:customer_id])
    
    # s = 'qr codes are the new hotness'
    # fname = s.gsub(/\s+/,"_") + ".qr.png"
    # Qr4r::encode(s, fname)
  end
  
  def check_for_admin
    if !current_user
      redirect_to root_path
    else
      if current_user.administrator != true && current_user.administrator != 1
        redirect_to root_path
      end
    end
  end
end