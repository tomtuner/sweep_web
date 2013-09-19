class AddCustomerIdToAdvisors < ActiveRecord::Migration
  def change
	add_column :advisors, :customer_id, :integer
  end
end
