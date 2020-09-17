class CreateAdministrators < ActiveRecord::Migration[6.0]
  def change
    create_table :administrators do |t|
      add_foreign_key t, :members, :name => "member_id", :primary_key => true
      add_foreign_key t, :members, :name => "created_by", :null => false
      add_foreign_key t, :members, :name => "last_updated_by"
      t.timestamps
    end
  end
end
