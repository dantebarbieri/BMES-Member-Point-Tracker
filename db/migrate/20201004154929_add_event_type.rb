# frozen_string_literal: true

class AddEventType < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :event_type
    add_column :events, :event_type, :integer
  end
end
