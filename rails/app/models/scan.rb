class Scan < ActiveRecord::Base
  attr_accessible :event_id, :scanned_at, :value
end
