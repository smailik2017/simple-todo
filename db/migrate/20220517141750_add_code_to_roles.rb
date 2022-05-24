class AddCodeToRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :code, :string
  end
end
