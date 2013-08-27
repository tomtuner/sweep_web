module Api
  module V1
    class ApplicationController < ActionController::Base
      protect_from_forgery
      # force_ssl
    end
  end
end