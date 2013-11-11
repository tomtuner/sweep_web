class AddIndexOnScansEventId < ActiveRecord::Migration
  def up
        add_index :scans, :event_id
  end

  def down
    remove_index :scans, :event_id
  end
end
