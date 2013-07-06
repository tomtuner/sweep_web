class AddThemeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :theme, :string
  end
end
