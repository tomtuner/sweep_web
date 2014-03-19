Sweep::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # config.paperclip_defaults = {
 #    :storage => :s3,
 #    :s3_credentials => {
 #      :bucket => ENV['S3_DEV_BUCKET_NAME'],
 #      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
 #      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
 #    }
 #  }
  
  # AWS::S3::Base.establish_connection!(
     # :access_key_id     => ENV['AWS_DEV_ACCESS_KEY_ID'],
     # :secret_access_key => ENV['AWS_DEV_SECRET_ACCESS_KEY']
   # )
   
   S3_CREDENTIALS = YAML.load(File.read(File.expand_path(Rails.root.join("config","aws.yml"))))["development"]
   AWS.config({
     :access_key_id     => 'AKIAI5NICTEIB34OL7WA',
     :secret_access_key => 'LBDrBnFm+us1dx7/ix22QbIYYjxJxLWR88vgK3O2',
     :region            =>  'us-east-1',
   })

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make {code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "mail.sweepevents.com",
    :user_name            => "thomas.demeo@sweepevents.com",
    :password             => "thomas828",
    :authentication       => :plain,
    :enable_starttls_auto => true
  }

  config.action_mailer.default_url_options = {
    :host => "developer.sweepevents.com"
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  
  config.action_mailer.default_url_options = { host: "developer.sweepevents.com" }
end
