class EventsController < ApplicationController

  before_filter :require_login

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @good_user = 0
    
    @user = current_user
    @department = current_department
    if @user
      @department = Department.find(@event[:department_id])
      @advisors = Advisor.find_all_by_user_id(current_user[:id])
      if @advisors.count > 0
        @advisors.each do |a|
          if a.department_id == @event.department_id
            if a.user_id == current_user.id
              @good_user = 1
            end
          end
        end
      else
        redirect_to root_path
        return
      end
    
      
    elsif @department
      @event_dept = Department.find(@event[:department_id])
      if @department == @event_dept
        @good_user = 1
      end
    end
    
    if @good_user == 0
      redirect_to root_path
      return
    end
    @scans = Scan.where("event_id = ?", @event[:id]).order("scanned_at DESC")
    
    respond_to do |format|
      format.html # show.html.erb
      format.csv { send_data @scans.to_csv }
      format.xls
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, :notice => 'Event was successfully created.' }
        format.json { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, :notice => 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
