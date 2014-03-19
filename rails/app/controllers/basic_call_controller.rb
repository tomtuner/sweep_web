class BasicCallController < ApplicationController
  
  def index
    # @devices = Device.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @response }
    end
  end
  
end
