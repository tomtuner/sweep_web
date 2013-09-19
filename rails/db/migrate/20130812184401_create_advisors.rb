class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.integer :user_id
      t.integer :department_id

      t.timestamps
    end
  end
end
