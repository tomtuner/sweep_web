class AddIndexOnValidKey < ActiveRecord::Migration
  def up
	add_index :departments, :valid_key, :unique => true
  end

  def down
    remove_index :departments, :valid_key
  end
end
