class AccountsController < ApplicationController
  def index
    @user = current_user
    if @user
      # if @user[:administrator] == 1
        # User is an administrator
      # else
        #User is not an administrator
        # if (params[:csv] && params[:xls])
        
          @department = Department.find(params[:department_id])
          @events = Event.find(:all, order: "starts_at DESC", :conditions => ["department_id = ?", @department.id], :limit => 20)
          @scans = Scan.where("event_id IN (?)", @events.map(&:id))
          
        # end
      end
        # @advisors = Advisor.find_all_by_user_id(@user[:id])
#         if @advisors.count > 1
#           @departments = Department.find(@advisors.map(&:department_id).uniq)
#         elsif @advisors.count == 1
#           @department = Department.find(@advisors.first.department_id)
#           if (params[:csv] && params[:xls])
#             redirect_to controller: "departments", action: "show", id: @department.id
#           else
#             @events = Event.find(:all, order: "starts_at DESC", :conditions => ["department_id = ?", @department.id], :limit => 20)
#             @scans = Scan.where("event_id IN (?)", @events.map(&:id))
#           end
#           return
#         else
#           
#         end
#     end
    
    respond_to do |format|
      format.html
      format.csv { send_data @scans.to_csv }
      format.xls
    end
  end
end
