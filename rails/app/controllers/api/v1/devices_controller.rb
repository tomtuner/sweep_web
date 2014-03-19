module Api
  module V1
    class DevicesController < ApplicationController
      respond_to :json
      
      def index
        respond_with Device.all
      end
      
      def show
        respond_with Device.find(params[:id])
      end
      
      def create
        respond_with Device.create(params[:device])
      end
      
      def update
        respond_with Device.update(params[:id], params[:device])
      end
      
      def destroy
        respond_with Device.destroy(params[:id])
      end
    end
  end
end
