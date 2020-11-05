class AddEventPtId < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :participation_tracker_id, :bigint, :null => true
  end
end
