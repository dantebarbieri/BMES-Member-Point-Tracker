class CreateAwards < ActiveRecord::Migration[6.0]
  def change
    create_table :awards do |t|
      t.text "name"
      t.text "description"
      t.decimal "points", :default => 0
      add_foreign_key t, :members, :name => "created_by", :null => false
      add_foreign_key t, :members, :name => "last_updated_by"
      t.timestamps
    end
  end
end
