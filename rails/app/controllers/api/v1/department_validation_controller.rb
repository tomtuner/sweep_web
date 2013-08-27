module Api
  module V1
    class DepartmentValidationController < SecureApplicationController
      respond_to :json

      def create
        department = Department.validate_key(params[:valid_key])
        if department
          customer = Customer.find_by_id(department[:customer_id])
        end

        if department && customer
          # response = {:department => department, :customer => customer}
          # respond_with department, customer
          render :json => {
            :department => department,
            :customer => customer
          }
        else
          render :json =>"", :status => :unauthorized
        end
      end
      
      def index
        department = Department.validate_key(params[:valid_key])
        if department
          customer = Customer.find_by_id(department[:customer_id])
        end

        if department && customer
          # response = {:department => department, :customer => customer}
          # respond_with department, customer
          render :json => {
            :department => department,
            :customer => customer
          }
        else
          render :json =>"", :status => :unauthorized
        end
      end
    end
  end
end