module Api
  module V1
    class EventsController < SecureApplicationController
      before_filter :check_department_key
      respond_to :json
      
      def index
        respond_with Event.all
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
      
      private
      def check_department_key
        department = params[:department]
        valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        head :unauthorized unless valid_dep
      end
      
    end
  end
end