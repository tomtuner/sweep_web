module Api
  module V1
    class DepartmentsController < SecureApplicationController      
      respond_to :json
      
      def index
        @department = Department.all
        respond_with(:api, @department)
      end
      
      def show
        @department = Department.find(params[:id])
        respond_with(:api, @department)
      end
      
      def create
        @department = Department.create(params[:department])
        respond_with(:api, @department)
      end
      
      def update
        @department = Department.update(params[:id], params[:department])
        respond_with(:api, @department)
      end
      
      def destroy
        @department = Department.destroy(params[:id])
        respond_with(:api, @department)
      end
      
    end
  end
end