class Scan < ActiveRecord::Base
  attr_accessible :event_id, :scanned_at, :value
  validates :value, :presence => true
  validates :value, :numericality => {:only_integer => true}
  validates :event_id, :presence => true
  
end
