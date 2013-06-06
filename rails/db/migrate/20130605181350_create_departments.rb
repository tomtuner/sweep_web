class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :customer_id
      t.string :name
      t.string :valid_key

      t.timestamps
    end
  end
end
