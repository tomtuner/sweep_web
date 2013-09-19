class AdvisorsController < ApplicationController
  
  before_filter :require_login
  
  def new
    @advisor = Advisor.new
    @users = User.find_all_by_customer_id(current_user[:customer_id])
    @departments = Department.find_all_by_customer_id(current_user[:customer_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @advisor }
    end
  end

  # POST /departments
  # POST /departments.json
  def create
    @advisor = Advisor.new(params[:advisor])
    @advisor[:customer_id] = current_user[:customer_id]
    respond_to do |format|
      if @advisor.save
        format.html { redirect_to controller: "admin", action: "index" }
        format.json { render :json => @advisor, :status => :created, :location => @advisor }
      else
        format.html { render :action => "new" }
        format.json { render :json => @advisor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
