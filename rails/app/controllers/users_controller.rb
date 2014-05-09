require 'qr4r'
# require 'aws/s3'

class UsersController < ApplicationController
  http_basic_authenticate_with :name => 'SweepEvents', :password => 'SweepEvents9', except: [:update]
  def new
    @user = User.new
    @customers = Customer.all
  end
  
  def create
    @user = User.new(params[:user])
    
    # Don't know why these were here
    # @departments = Department.find_all_by_customer_id(current_user[:customer_id])    
    # @advisors = Advisor.find_all_by_customer_id(current_user[:customer_id])
    
    fname = @user.u_id.to_s + ".png"
    Qr4r::encode(@user.u_id.to_s, fname, :pixel_size => 10)
    
    ApplicationController.helpers.upload_to_s3(fname, ApplicationController.helpers.s3_bucket_name)
    File.delete(fname) if File.exist?(fname)
    # s3 = AWS::S3.new
 #    bucket_name = ApplicationController.helpers.s3_bucket_name
 #    obj = s3.buckets[bucket_name].objects[fname]
 #    obj.write(Pathname.new(fname))
    
    
    # AWS::S3Object.store(fname, open(fname), 'qr-dev.sweep.kanzu/codes')
    # 
    # respond_to do |format|
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        redirect_to root_path, :notice => "Signed Up!"
      else
        @customers = Customer.all
        render "new"
      end
    # end
  end
  
  def show
    @user = User.find(params[:id])
    
    
    
  end
  
  def update
    user = User.find(params[:id])
    new_user = params[:user]
    
    # Check that user typed in there correct old password
    if User.authenticate(user.email, params[:old_password])
      respond_to do |format|
        if user.update_attributes(new_user)
          format.html { redirect_to root_url, :notice => 'Password Successfully Updated' }
          format.json { head :no_content }
        else
          format.html {  }
          format.json { render :json => user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
end
