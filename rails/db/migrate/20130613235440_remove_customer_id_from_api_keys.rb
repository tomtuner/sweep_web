class RemoveCustomerIdFromApiKeys < ActiveRecord::Migration
  def up
	remove_column :api_keys, :customer_id
  end

  def down
	add_column :api_keys, :customer_id
  end
end
