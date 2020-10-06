class AddUidToMember < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :uid, :text, unique: true, null: false
    add_index :members, :uid, unique: true
  end
end
