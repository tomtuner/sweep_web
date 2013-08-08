class AddEncryptedIvToScans < ActiveRecord::Migration
  def change
     add_column :scans, :encrypted_iv, :text 
  end
end
