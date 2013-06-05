class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :value
      t.datetime :scanned_at
      t.integer :event_id

      t.timestamps
    end
  end
end
