class Department < ActiveRecord::Base
  has_many :events
  attr_accessible :customer_id, :name, :valid_key
  after_initialize :init
  validates :customer_id, :presence => true
  validates :name, :uniqueness => true
  validates_associated :events
  
  private
    def init
      self.valid_key ||= SecureRandom.hex(5)
    end
end