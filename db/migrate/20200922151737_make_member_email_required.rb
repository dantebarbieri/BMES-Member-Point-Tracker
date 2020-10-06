# frozen_string_literal: true

class MakeMemberEmailRequired < ActiveRecord::Migration[6.0]
  def up
    change_column :members, :email, :text, unique: true, null: false
  end

  def down
    change_column :members, :email, :text, unique: true
  end
end
