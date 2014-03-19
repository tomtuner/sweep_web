# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sweep::Application.initialize!
# ENV['RAILS_ENV'] ||= 'development'
ENV['S3_DEV_BUCKET_URL']='qr-dev.sweep.kanzu'
ENV['AWS_DEV_ACCESS_KEY_ID']='AKIAI5NICTEIB34OL7WA'
ENV['AWS_DEV_SECRET_ACCESS_KEY']='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'