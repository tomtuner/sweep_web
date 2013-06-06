module Api
  module V1
    class DepartmentsController < SecureApplicationController      
      respond_to :json
      
      def index
        respond_with Department.all
      end
      
      def show
        respond_with Department.find(params[:id])
      end
      
      def create
        respond_with Department.create(params[:department])
      end
      
      def update
        respond_with Department.update(params[:id], params[:department])
      end
      
      def destroy
        respond_with Department.destroy(params[:id])
      end
      
    end
  end
end