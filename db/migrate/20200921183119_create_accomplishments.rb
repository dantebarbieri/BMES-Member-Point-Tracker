# frozen_string_literal: true

class CreateAccomplishments < ActiveRecord::Migration[6.0]
  def change
    create_table :accomplishments do |t|
      t.text 'name'
      t.text 'description'
      t.decimal 'points', default: 0
      t.timestamps
    end
  end
end
