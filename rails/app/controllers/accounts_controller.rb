class AccountsController < ApplicationController
  def index
    @user = current_user
    if @user
      # if @user[:administrator] == 1
        # User is an administrator
      # else
        #User is not an administrator
        @advisors = Advisor.find_all_by_user_id(@user[:id])
        if @advisors.count > 1
          @departments = Department.find(@advisors.map(&:department_id).uniq)
        elsif @advisors.count == 1
          @departments = Department.find(@advisors.map(&:department_id).uniq)
          @events = Event.find(:all, order: "created_at DESC", :conditions => ["department_id = ?", @departments.map(&:id)], :limit => 20)
          @scans = Scan.where("event_id IN (?)", @events.map(&:id))
          
        else
          
        end
      # end
    end
    
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv }
      format.xls
    end
  end
end
