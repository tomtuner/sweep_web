class Customer < ActiveRecord::Base
  attr_accessible :name, :theme
  validates :name, :presence => true
  
end