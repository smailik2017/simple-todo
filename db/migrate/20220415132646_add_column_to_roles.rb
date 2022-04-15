class AddColumnToRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :users_count, :integer
  end
end
