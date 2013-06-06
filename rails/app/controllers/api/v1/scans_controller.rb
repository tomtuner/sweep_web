module Api
  module V1
    class ScansController < SecureApplicationController
      before_filter :check_department_key
      respond_to :json
      
      def index
        respond_with Scan.all
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
        department = params[:department]
        valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        head :unauthorized unless valid_dep
      end
      
    end
  end
end
