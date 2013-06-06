class Event < ActiveRecord::Base
  has_one :department
  has_many :scans
  validates_associated :department, :scans
  validates :department_id, :presence => true
  validates :name, :presence => true
  attr_accessible :department_id, :name
  
end
