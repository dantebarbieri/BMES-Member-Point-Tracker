class ChangeReceivedToSemester < ActiveRecord::Migration[6.0]
  def change
    remove_column :accomplishments_members, :received
    add_reference :accomplishments_members, :semester, :foreign_key => true
  end
end
