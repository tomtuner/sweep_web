module Api
  module V1
    class DepartmentValidationController < SecureApplicationController
      respond_to :json

      def create
        department = Department.validate_key(params[:valid_key])
        Rails.logger.info department
        if department
          respond_with department
        else
          render :json =>"", :status => :unauthorized
        end
      end
    end
  end
end