module Api
  module V1
    class EventsController < SecureApplicationController
      before_filter :check_department_key
      respond_to :json
      
      def index
        # department = params[:department]
        # Add this back in
        # valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        valid_dep = Department.validate_key(params[:valid_key])
        
        # events = Event.find_by_department_id_updated_after(valid_dep[:id], params[:updated_at])
        if params[:updated_at]
          updated_at_date = DateTime.strptime(params[:updated_at], '%Y-%m-%dT%H:%M:%S%z')
          @events = Event.where("department_id = ? AND updated_at > ?",  valid_dep[:id], updated_at_date)
        else
          @events = Event.where("department_id = ?",  valid_dep[:id])
        end
        # events = Event.find_by_department_id(valid_dep[:id])
        #Rails.logger.info(events)
        
        respond_with(:api, @events, :except => [:starts_at, :ends_at])
      end
      
      def show
        @event = Event.find(params[:id])
        respond_with(:api, @event, :except => [:starts_at, :ends_at])
      end
      
      def create
        @event = Event.create(params[:event])
        respond_with(:api, @event, :except => [:starts_at, :ends_at])
      end
      
      def update
        @event = Event.update(params[:id], params[:event])
        respond_with(:api, @event, :except => [:starts_at, :ends_at])
      end
      
      def destroy
        @event = Event.destroy(params[:id])
        respond_with(:api, @event, :except => [:starts_at, :ends_at])
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