class CreateAdministrators < ActiveRecord::Migration[6.0]
  def change
    create_table :administrators do |t|
      t.belongs_to :member, foreign_key: true
      t.timestamps
    end
  end
end
