class ChangeReceivedToSemester < ActiveRecord::Migration[6.0]
  def up
    remove_column :accomplishments_members, :received
    add_reference :accomplishments_members, :semester, :foreign_key => true
  end

  def down
    remove_reference :accomplishments_members, :semester
    add_column :accomplishments_members, :received, :datetime
  end
end
