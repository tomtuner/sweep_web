class AddEventTimesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :starts_at, :datetime
    add_column :events, :ends_at, :datetime
    
    say_with_time "Updating Events..." do
     Event.find(:all).each do |e|
       e.update_attribute :starts_at, e.created_at
       e.update_attribute :ends_at, e.created_at
     end
    end
  end
end
