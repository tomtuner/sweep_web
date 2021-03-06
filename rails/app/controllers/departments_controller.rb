class DepartmentsController < ApplicationController
  
  before_filter :require_login
  
  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @departments }
    end
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = Department.find(params[:id])
    @advisors = Advisor.find_all_by_user_id(current_user[:id])
    @good_user = 0
    if @advisors.count > 0
      @advisors.each do |a|
        if a.department_id == @department.id
          if a.user_id == current_user.id
            @good_user = 1
          end
        end
      end
    else
      redirect_to root_path
      return
    end
    
    if @good_user == 0
      redirect_to root_path
      return
    end
    
    @events = Event.find(:all, order: "starts_at DESC", :conditions => ["department_id = ?", @department.id], :limit => 20)
    @scans = Scan.where("event_id IN (?)", @events.map(&:id))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @department }
    end
  end

  # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new
    @customers = Customer.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @department }
    end
  end

  # GET /departments/1/edit
  def edit
    @department = Department.find(params[:id])
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(params[:department])
    @department[:customer_id] = current_user[:customer_id]
    respond_to do |format|
      if @department.save
        format.html { redirect_to controller: "admin", action: "index" }
        format.json { render :json => @department, :status => :created, :location => @department }
      else
        format.html { render :action => "new" }
        format.json { render :json => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /departments/1
  # PUT /departments/1.json
  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(params[:department])
        format.html { redirect_to @department, :notice => 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    respond_to do |format|
      format.html { redirect_to departments_url }
      format.json { head :no_content }
    end
  end
end
