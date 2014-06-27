require 'qr4r'

module Api
  module V2
    class ScansController < SecureApplicationController
      before_filter :check_department_key, except: [:registration]
      respond_to :json
      
      def index
        # Add this back in
        # valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        valid_dep = Department.validate_key(params[:valid_key])
        # valid_event = Event.find
        # events = Event.find_by_department_id_updated_after(valid_dep[:id], params[:updated_at])
        event = params[:event]
        
        # scans = Scan.where("event_id = ?",  params[:event_id])
        
        if params[:updated_at] && event          
          updated_at_date = DateTime.strptime(params[:updated_at], '%Y-%m-%dT%H:%M:%S%z')
          @scans = Scan.where("event_id = ? AND updated_at > ?", valid_dep[:id], event[:id], updated_at_date)
        elsif params[:updated_at] && event.nil?
          event_ids = Event.where("department_id = ?", valid_dep[:id]).select("id")
          
          updated_at_date = DateTime.strptime(params[:updated_at], '%Y-%m-%dT%H:%M:%S%z')
          @scans = Scan.where("event_id IN (?) AND updated_at > ?", event_ids, updated_at_date)
          # scans = Scan.where("event_id = ?",  event[:id])
        elsif params[:updated_at].nil? && event
          @scans = Scan.where("event_id = ?",  event[:id])        
        else
          event_ids = Event.where("department_id = ?", valid_dep[:id]).select("id")
          # Rails.logger.info(event_ids)
          # scans = Scan.find_by_event_id(event_ids)
          @scans = Scan.where("event_id IN (?)", event_ids)
        end
        # Rails.logger.info("Scans: " + scans.to_su)
        respond_with(:api, @scans)
      end
      
      def show
        @scan = Scan.find(params[:id])
        respond_with(:api, @scan)
      end
      
      def create
        @scan = Scan.create(params[:scan])
        respond_with(:api, @scan)
      end
      
      def update
        tempScan = params[:scan]
        id = tempScan[:id]
        @scan = Scan.update(id, tempScan) 
        respond_with(:api, @scan)
      end
      
      def destroy
        @scan = Scan.destroy(params[:id])
        respond_with(:api, @scan)
      end
      
      def registration
        status = 200
        message = "Success"
        @user = User.new(params[:user])
        @scan = Scan.new(params[:scan])

        if !(@user.first_name && @user.last_name && @user.email)
          status = 400
          message = "Invalid user credentials"
        elsif !@scan.event_id
          status = 400
          message = "Invalid scan credentials"
        else 
          # Valid Request
          if !(@user = User.find_by_email(@user.email))
            @user = User.new(params[:user])
            fname = @user.u_id.to_s + ".png"
            Qr4r::encode(@user.u_id.to_s, fname, :pixel_size => 10)
      
            ApplicationController.helpers.upload_to_s3(fname, ApplicationController.helpers.s3_bucket_name)
            File.delete(fname) if File.exist?(fname)
          
            # Set users temp password
            @user.password = SecureRandom.hex(10)
            logger.debug @user.password
            @user.save
          end
          @scan.value = @user.u_id.to_s
          
          # Can't do this until it is added to scans
          @scan.registered_at = Time.now
          @scan.user_id = @user.id
          @scan.status = 0
          @scan.save
          
          # Send confirmation email
          UserMailer.registration_confirmation(@user).deliver
          # respond_with(:api, @user)
        end
        response = {
          status: status,
          message: message
        }
        render json: response, status: status, content_type: "application/json"
      end
      
      private
      def check_department_key
        # department = params[:department]
        # Add this back in
        # valid_dep = Department.find_by_valid_key_and_customer_id(department[:valid_key], department[:customer_id])
        valid_dep = Department.validate_key(params[:valid_key])
        
        head :unauthorized unless valid_dep
        
      end
      
    end
  end
end
