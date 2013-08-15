class AddCustomerIdAndAdministratorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :integer
    add_column :users, :administrator, :integer, :limit => 1
  end
end
