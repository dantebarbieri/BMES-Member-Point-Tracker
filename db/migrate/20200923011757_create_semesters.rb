# frozen_string_literal: true

class CreateSemesters < ActiveRecord::Migration[6.0]
  def change
    create_table :semesters do |t|
      t.text :name
      t.daterange :dates, null: false, unique: true
      t.timestamps
    end
  end
end
