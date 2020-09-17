class CreateManualPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :manual_points do |t|
      add_foreign_key t, :members, :name => "member_id", :null => false
      t.decimal "points", :default => 0
      t.text "reason"
      add_foreign_key t, :members, :name => "created_by", :null => false
      add_foreign_key t, :members, :name => "last_updated_by"
      t.timestamps
    end
  end
end
