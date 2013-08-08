# APP_CONFIG = YAML.load_file(Rails.root.to_s + '/config/config.yml')[RAILS_ENV]
APP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/config.yml")).result)[Rails.env]
