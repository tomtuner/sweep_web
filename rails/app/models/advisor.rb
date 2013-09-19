class Advisor < ActiveRecord::Base
  attr_accessible :department_id, :user_id
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :department_id, presence: true, numericality: { only_integer: true }
  validate :validate_user_and_department_id
  
  private
  def validate_user_and_department_id
    if !User.exists?(self.user_id)
      errors.add(:user_id, "is invalid")
    end
    if !Department.exists?(self.department_id)
      errors.add(:department_id, "is invalid")
    end
  end
  
end
