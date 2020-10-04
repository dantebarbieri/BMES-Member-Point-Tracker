class RemoveAdminTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :administrators
  end
end
