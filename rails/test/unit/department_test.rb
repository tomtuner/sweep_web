require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  fixtures :departments
     test "department is not valid without a unique name" do
       department = Department.new(:name => departments(:one).name,
                                   :customer_id => 1)
                                 
       assert !department.save
       assert_equal "has already been taken", department.errors[:name].join('; ')
     end
     test "department customer id is valid" do
       customer = Customer.find_by_id(departments(:one).customer_id)
       assert customer
     end
end