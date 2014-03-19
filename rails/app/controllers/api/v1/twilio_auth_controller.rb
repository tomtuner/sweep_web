require "twilio-ruby"

module Api
  module V1  
    class TwilioAuthController < ApplicationController
      
      respond_to :json
      
      def index
        account_sid = 'AC84a7a47124c8470ee2c725591b62a733'
        auth_token = '6396b615047c39f31270158d665b0af5'
        app_sid = "AP3532e12a6c69d8fde28c177321781a24";
        
        client_name = params[:clientName]
        
        capability = Twilio::Util::Capability.new account_sid, auth_token
        capability.allow_client_outgoing app_sid
        capability.allow_client_incoming client_name
        
        respond_with capability.generate
        # respond_with Device.all
      end
      
      # def show
      #   respond_with Device.find(params[:id])
      # end
      # 
      # def create
      #   respond_with Device.create(params[:device])
      # end
      # 
      # def update
      #   respond_with Device.update(params[:id], params[:device])
      # end
      # 
      # def destroy
      #   respond_with Device.destroy(params[:id])
      # end
    end
  end
end