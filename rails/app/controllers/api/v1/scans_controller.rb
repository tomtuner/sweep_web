module Api
  module V1
    class ScansController < SecureApplicationController
      before_filter :check_department_key
      respond_to :json
      
      def index
        # Add this back in
        # valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        # valid_dep = Department.validate_key(params[:valid_key])
        # valid_event = Event.find
        # events = Event.find_by_department_id_updated_after(valid_dep[:id], params[:updated_at])
        scans = Scan.where("event_id = ?",  params[:event_id])
        # events = Event.find_by_department_id(valid_dep[:id])
        Rails.logger.info(scans)
        
        respond_with scans
      end
      
      def show
        respond_with Scan.find(params[:id])
      end
      
      def create
        respond_with Scan.create(params[:scan])
      end
      
      def update
        respond_with Scan.update(params[:id], params[:scan])
      end
      
      def destroy
        respond_with Scan.destroy(params[:id])
      end
      
      private
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
