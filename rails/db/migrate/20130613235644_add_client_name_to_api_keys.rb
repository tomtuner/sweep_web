class AddClientNameToApiKeys < ActiveRecord::Migration
  def change
	add_column :api_keys, :client_name, :string
  end
end
