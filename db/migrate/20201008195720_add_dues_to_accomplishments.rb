# frozen_string_literal: true

class AddDuesToAccomplishments < ActiveRecord::Migration[6.0]
  def change
    add_column :accomplishments, :is_dues, :boolean
  end
end
