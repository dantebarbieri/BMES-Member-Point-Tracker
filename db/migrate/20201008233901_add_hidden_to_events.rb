# frozen_string_literal: true

class AddHiddenToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :hidden, :boolean
  end
end
