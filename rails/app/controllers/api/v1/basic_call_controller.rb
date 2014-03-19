require "twilio-ruby"

module Api
  module V1  
    class BasicCallController < ApplicationController
      # respond_to :json
      respond_to :xml
      
      def index
        # numberToCall = params[:Called]
        # Rails.logger.info(numberToCall)
        # if (!numberToCall)
          numberToCall = params[:PhoneNumber]
          # Rails.logger.info(numberToCall)
          if (numberToCall.to_s.empty?)
            numberToCall = params[:Called]
          end
          numberToCall = numberToCall.gsub(/[^0-9]/, "")
        # end
        
         cert = File.read(File.join(Rails.root, 'config', 'ck.pem'))
         ctx = OpenSSL::SSL::SSLContext.new
         ctx.key = OpenSSL::PKey::RSA.new(cert, 'WhoaPhone') #set passphrase here, if any
         ctx.cert = OpenSSL::X509::Certificate.new(cert)
  #  
         sock = TCPSocket.new('gateway.sandbox.push.apple.com', 2195) #development gateway
         ssl = OpenSSL::SSL::SSLSocket.new(sock, ctx)
         ssl.connect
  # 
        payload = {"aps" => {"alert" => "Incoming Call!", "badge" => 1, "sound" => 'default'}}
        json = payload.to_json()
         device = Device.find_by_ph_num(numberToCall)
         if device
           token = device.token
           token =  [token.delete(' ')].pack('H*') #something like 2c0cad 01d1465 346786a9 3a07613f2 b03f0b94b6 8dde3993 d9017224 ad068d36
           apnsMessage = "\0\0 #{token}\0#{json.length.chr}#{json}"
           ssl.write(apnsMessage)
   
           ssl.close
           sock.close
         end
        @response = Twilio::TwiML::Response.new do |r|
          r.Dial :callerId => '16318136374', :timeout => "10", :action => "/record-or-hangup", :method => "get" do |d|
            if device
              d.Client numberToCall
            else
              d.Number numberToCall
            end
          end
        end
        # response.accept = 'application/xml'
        respond_with (@response.text) do |format|
          format.xml {render :xml => @response.text}
        end
      end
    end
    get '/call-fail' do
      Twilio::TwiML::Response.new do |r|
        r.Say 'Caller was not found'
    end
  end
end