class MakeMemberEmailRequired < ActiveRecord::Migration[6.0]
  def change
    change_column :members, :email, :text, :unique => true, :null => false
  end
end
