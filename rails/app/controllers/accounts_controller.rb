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
        
        else

        end 
      end
    end
  end
end
