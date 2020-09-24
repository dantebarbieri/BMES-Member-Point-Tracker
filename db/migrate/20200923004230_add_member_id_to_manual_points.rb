class AddMemberIdToManualPoints < ActiveRecord::Migration[6.0]
  def change
    add_reference :manual_points, :member, foreign_key: true
  end
end
