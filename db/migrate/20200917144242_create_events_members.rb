class CreateEventsMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :events_members do |t|
      add_foreign_key t, :events, :name => "event_id", :null => false
      add_foreign_key t, :members, :name => "member_id", :null => false
      t.timestamps
    end
  end
end
