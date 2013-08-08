class AddEncryptedKeyToScans < ActiveRecord::Migration
  def change
    add_column :scans, :encrypted_key, :text
  end
end
