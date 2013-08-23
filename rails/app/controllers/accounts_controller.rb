class AccountsController < ApplicationController
  def index
    @user = current_user
    if @user
      if @user[:administrator] == 1
        # User is an administrator
      else
        #User is not an administrator
        @advisors = Advisor.find_all_by_user_id(@user[:id])
        if @advisors.count > 1
          @departments = Department.find(@advisors.map(&:department_id).uniq)
        elsif @advisors.count == 1
          @departments = Department.find(@advisors.map(&:department_id).uniq)
          @events = Event.find(:all, order: "created_at DESC", :conditions => ["department_id = ?", @departments.map(&:id)], :limit => 20)
        else
          
        end
      end
    end
  end
end