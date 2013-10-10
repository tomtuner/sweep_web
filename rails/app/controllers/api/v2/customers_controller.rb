module Api
  module V2
    class CustomersController < SecureApplicationController
      respond_to :json
      
      def index
        @customer = Customer.all
        respond_with(:api, @customer)
      end
      
      def show
        @customer = Customer.find(params[:id])
        respond_with(:api, @customer)
      end
      
      def create
        @customer = Customer.create(params[:customer])
        respond_with(:api, @customer)
      end
      
      def update
        @customer = Customer.update(params[:id], params[:customer])
        respond_with(:api, @customer)
      end
      
      def destroy
        @customer = Customer.destroy(params[:id])
        respond_with(:api, @customer)
      end
    end
  end
end
