class AddSemesterIdToManualPoints < ActiveRecord::Migration[6.0]
  def change
    add_reference :manual_points, :semester, foreign_key: true
  end
end
