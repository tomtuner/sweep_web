module Api
  module V1
    class ScansController < ApplicationController
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
    end
  end
end
