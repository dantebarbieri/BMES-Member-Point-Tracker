# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text 'name'
      t.date 'date', null: false
      t.time 'time'
      t.text 'type'
      t.decimal 'attendance_points', default: 0
      t.timestamps
    end
  end
end
