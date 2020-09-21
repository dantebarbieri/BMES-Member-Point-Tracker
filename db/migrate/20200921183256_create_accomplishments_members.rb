class CreateAccomplishmentsMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :accomplishments_members do |t|
      t.belongs_to :accomplishment, foreign_key: true
      t.belongs_to :member, foreign_key: true
      t.datetime "received"
      t.timestamps
    end
  end
end
