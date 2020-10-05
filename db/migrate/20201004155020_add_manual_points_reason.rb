class AddManualPointsReason < ActiveRecord::Migration[6.0]
  def change
    rename_column :manual_points, :reason, :reason_message
    add_column :manual_points, :reason, :integer
  end
end
