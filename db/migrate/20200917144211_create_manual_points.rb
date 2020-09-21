class CreateManualPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :manual_points do |t|
      t.decimal "points", :default => 0
      t.text "reason"
      t.timestamps
    end
  end
end
