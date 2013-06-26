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
        events = Event.where("department_id = ?",  valid_dep[:id])
        # events = Event.find_by_department_id(valid_dep[:id])
        Rails.logger.info(events)
        
        respond_with events
      end
      
      def show
        respond_with Event.find(params[:id])
      end
      
      def create
        respond_with Event.create(params[:event])
      end
      
      def update
        respond_with Event.update(params[:id], params[:event])
      end
      
      def destroy
        respond_with Event.destroy(params[:id])
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