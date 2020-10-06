# frozen_string_literal: true

class AddMemberRole < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :role, :integer
  end
end
