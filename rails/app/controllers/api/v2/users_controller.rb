module Api
  module V2
    class UsersController < SecureApplicationController
      before_filter :check_department_key
      respond_to :json
      
      def index
        # department = params[:department]
        # Add this back in
        # valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        valid_dep = Department.validate_key(params[:valid_key])
        scan = params[:scan]
        # events = Event.find_by_department_id_updated_after(valid_dep[:id], params[:updated_at])
        if params[:updated_at]
          updated_at_date = DateTime.strptime(params[:updated_at], '%Y-%m-%dT%H:%M:%S%z')
          event_ids = Event.where("department_id = ?", valid_dep[:id]).select("id")
          scans = Scan.where("event_id IN (?) AND user_id IS NOT NULL", event_ids).select("user_id")
          logger.info scans
          @users = User.where("id IN (?) AND updated_at > ?",  scans, updated_at_date)
        else
          event_ids = Event.where("department_id = ?", valid_dep[:id]).select("id")
          scans = Scan.where("event_id IN (?) AND user_id IS NOT NULL", event_ids).select("user_id")
          # logger.info scans[:user_id]
          @users = User.where("id IN (?)", scans.map(&:user_id)).select("id, email, first_name, last_name, u_id")
          # @last_sixty = Date.today - 60
 #          @next_sixty = Date.today + 60
 #          @events = Event.where("department_id = ? AND starts_at BETWEEN ? AND ?", valid_dep[:id], @last_sixty, @next_sixty)  
        end
        # events = Event.find_by_department_id(valid_dep[:id])
        #Rails.logger.info(events)
        
        respond_with(:api, @users)
      end
      
      def show
        @user = User.find(params[:id])
        respond_with(:api, @users)
      end
      
      def create
        @user = Event.create(params[:event])
        respond_with(:api, @user)
      end
      
      def update
        @user = Event.update(params[:id], params[:event])
        respond_with(:api, @user)
      end
      
      def destroy
        @user = Event.destroy(params[:id])
        respond_with(:api, @user)
      end
      
      # private
      def check_department_key
        # department = params[:department]
        # Add this back in
        # valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        valid_dep = Department.validate_key(params[:valid_key])
        
        head :unauthorized unless valid_dep
      end
      
    end
  end
end