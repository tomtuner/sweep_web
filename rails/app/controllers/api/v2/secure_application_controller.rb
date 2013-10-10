module Api
  module V2
    class SecureApplicationController < ApplicationController
      # skip_before_filter :require_login
      before_filter :restrict_access
      private

        def restrict_access
          authenticate_or_request_with_http_token do |token, options|
            ApiKey.exists?(:access_token => token)
        end
      end
    end
  end
end