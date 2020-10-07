# frozen_string_literal: true

class CreateManualPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :manual_points do |t|
      t.belongs_to :member, foreign_key: true
      t.decimal 'points', default: 0
      t.text 'reason'
      t.timestamps
    end
  end
end
