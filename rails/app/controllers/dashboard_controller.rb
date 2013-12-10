class DashboardController < ApplicationController
  def index
    @scans = Scan.where(:event_id => "2").all
    
  end
end
