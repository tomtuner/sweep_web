module Api
  module V2
    class UserRegistrationController < SecureApplicationController
      respond_to :json
  
      def index
        @user = User.new(params[:user])
        @scan = Scan.create(params[:scan])
        if !(@user = User.find_by_email(@user.email))
          @user = User.new(params[:user])
          fname = @user.u_id.to_s + ".png"
          Qr4r::encode(@user.u_id.to_s, fname, :pixel_size => 10)
    
          ApplicationController.helpers.upload_to_s3(fname, ApplicationController.helpers.s3_bucket_name)
          File.delete(fname) if File.exist?(fname)
        
          # Set users temp password
          @user.password = SecureRandom.hex(10)
          @user.save
        end
        
        # Can't do this until it is added to scans
        # @scan.user_id = @user.id
        # @scan.status = 0
        # @scan.save
        
        # Send confirmation email
        # UserMailer.registration_confirmation(@user).deliver
        respond_with(:api, @user)
      end
      
      def create
        @user = User.new(params[:user])
        @scan = Scan.create(params[:scan])
        if !(@user = User.find_by_email(@user.email))
          @user = User.new(params[:user])
          fname = @user.u_id.to_s + ".png"
          Qr4r::encode(@user.u_id.to_s, fname, :pixel_size => 10)
    
          ApplicationController.helpers.upload_to_s3(fname, ApplicationController.helpers.s3_bucket_name)
          File.delete(fname) if File.exist?(fname)
        
          # Set users temp password
          @user.password = SecureRandom.hex(10)
          @user.save
        end
        
        # Can't do this until it is added to scans
        # @scan.user_id = @user.id
        # @scan.status = 0
        # @scan.save
        
        # Send confirmation email
        # UserMailer.registration_confirmation(@user).deliver
        respond_with(:api, @user)
      end
    end
  end
end