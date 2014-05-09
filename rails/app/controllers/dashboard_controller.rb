class DashboardController < ApplicationController
  def index
    # @scans = Scan.where(:event_id => "2").all
    
    # TODO Change here to check if there is a user, then check if the user is an advisor, then check for plan, then determine what to show    
    
    @beg_of_month = Date.today - (Time.now.day) + 1
  
    if @user = current_user
      @advisors = Advisor.find_all_by_user_id(current_user[:id])
      @month_events = Event.select("id").where("department_id IN (?) AND starts_at BETWEEN ? and ?", @advisors.map(&:department_id), @beg_of_month, Time.now)
      @events = Event.select("id, name, starts_at").where("department_id IN (?)", @advisors.map(&:department_id)).order("starts_at DESC").page(params[:page]).per(15)
      if @advisors.count > 1
        @departments = Department.find(@advisors.map(&:department_id).uniq)
      elsif @advisors.count == 1
        @department = Department.find(@advisors.first.department_id)
        @scans = Scan.select("event_id, value, created_at").where("event_id IN (?)", @events.map(&:id))
      else
        if !@user.plan
          @user = current_user
          user_id_hash = ApplicationController.helpers.encrypt_value_with_pass(@user.u_id.to_s)
          logger.debug user_id_hash
          @scans = Scan.select("event_id, value, created_at").where("value = ?", user_id_hash)
          @number_of_events = @scans.map(&:event_id).uniq.count
    
          render 'attendee_dash_index'
          return
        end
      end
      
      elsif @department = current_department
        @month_events = Event.select("id").where("department_id IN (?) AND starts_at BETWEEN ? AND ?", @department.id, @beg_of_month, Time.now)
        @events = Event.select("id, name, starts_at").where("department_id IN (?)", @department.id).order("starts_at DESC").page(params[:page]).per(15)
        @scans = Scan.select("event_id, value, created_at").where("event_id IN (?)", @events.map(&:id))
      end
    
      @month_scans = Scan.where("event_id IN (?)", @month_events.map(&:id)).count
      @month_scans_uniq = Scan.where("event_id IN (?)", @month_events.map(&:id)).count('value', :distinct => true)
    
    
    


    
    # @month_scans = Scan.where("created_at BETWEEN ? AND ?", @beg_of_month, Time.now)
    
    # @advisors = Advisor.find_all_by_user_id(current_user[:id])
#     if @advisors.count > 1
#       @departments = Department.find(@advisors.map(&:department_id).uniq)
#     elsif @advisors.count == 1
#       @department = Department.find(@advisors.first.department_id)
#     else
#       
#     end
#     
#     @events = Event.where("department_id IN (?)", @advisors.map(&:department_id)).order("starts_at DESC")
#     @scans = Scan.where("event_id IN (?)", @events.map(&:id))
#     
#     @month_scans = Scan.where("event_id IN (?) AND created_at BETWEEN ? AND ?", @events.map(&:id), @beg_of_month, Time.now)
#     
#     # @month_scans_uniq = 0
#     @month_scans_uniq = Scan.where("event_id IN (?) AND CREATED_at BETWEEN ? AND ?", @events.map(&:id), @beg_of_month, Time.now).count('value', :distinct => true)
#     
    # @month_scans = Scan.joins("INNER JOIN events ON scans.event_id = events.id").joins("INNER JOIN departments ON events.department_id IN (?)", @advisors.map(&:department_id))
#     @month_scans = 
#     @scans = Scan.where("event_id IN (?)", @events.map(&:id))
  end
end