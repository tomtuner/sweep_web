module Api
  module V1
    class EventsController < ApplicationController
      before_filter :restrict_access
      
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
      # def restrict_access
#         api_key = ApiKey.find_by_access_token(params[:access_token])
#         head :unauthorized unless api_key
#       end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(:access_token => token)
      end
    end
    end
  end
end