class DashboardController < ApplicationController
  def index
    # @scans = Scan.where(:event_id => "2").all
    
    @beg_of_month = Date.today - (Time.now.day) + 1
    @month_scans = Scan.where("created_at BETWEEN ? AND ?", @beg_of_month, Time.now)
    
    @advisors = Advisor.find_all_by_user_id(current_user[:id])
    @events = Event.where("department_id IN (?)", @advisors.map(&:department_id))
    @month_scans = Scan.where("event_id IN (?) AND created_at BETWEEN ? AND ?", @events.map(&:id), @beg_of_month, Time.now)
    
    # @month_scans = Scan.joins("INNER JOIN events ON scans.event_id = events.id").joins("INNER JOIN departments ON events.department_id IN (?)", @advisors.map(&:department_id))
#     @month_scans = 
#     @scans = Scan.where("event_id IN (?)", @events.map(&:id))
  end
end