class CreateAwardsMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :awards_members do |t|
      add_foreign_key t, :awards, :name => "award_id", :null => false
      add_foreign_key t, :members, :name => "member_id", :null => false
      add_foreign_key t, :members, :name => "given_by", :null => false
      t.datetime "received"
      t.timestamps
    end
  end
end
