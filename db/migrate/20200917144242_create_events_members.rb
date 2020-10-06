# frozen_string_literal: true

class CreateEventsMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :events_members, id: false do |t|
      t.belongs_to :member, foreign_key: true
      t.belongs_to :event, foreign_key: true
    end
  end
end
