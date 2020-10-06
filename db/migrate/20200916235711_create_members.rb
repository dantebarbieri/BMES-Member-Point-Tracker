# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.text 'name'
      t.text 'email', unique: true
      t.integer 'class_year'
      t.timestamps
    end
  end
end
