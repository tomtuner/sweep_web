class DashboardController < ApplicationController
  def index
    # @scans = Scan.where(:event_id => "2").all
    
    @beg_of_month = Date.today - (Time.now.day) + 1
    @user = current_user
    @department = current_department
    if @user
      @advisors = Advisor.find_all_by_user_id(current_user[:id])
      @events = Event.where("department_id IN (?)", @advisors.map(&:department_id)).order("starts_at DESC")
      if @advisors.count > 1
        @departments = Department.find(@advisors.map(&:department_id).uniq)
      elsif @advisors.count == 1
        @department = Department.find(@advisors.first.department_id)
        @scans = Scan.where("event_id IN (?)", @events.map(&:id))
      else
      
      end
      
    elsif @department
      @events = Event.where("department_id IN (?)", @department.id).order("starts_at DESC")
      @scans = Scan.where("event_id IN (?)", @events.map(&:id))
    end
    
    @month_scans = Scan.where("event_id IN (?) AND created_at BETWEEN ? AND ?", @events.map(&:id), @beg_of_month, Time.now)
    @month_scans_uniq = Scan.where("event_id IN (?) AND CREATED_at BETWEEN ? AND ?", @events.map(&:id), @beg_of_month, Time.now).count('value', :distinct => true)

    



    
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