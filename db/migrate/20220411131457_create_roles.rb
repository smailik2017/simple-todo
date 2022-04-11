class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :active
      t.string :description

      t.timestamps
    end
    add_index :roles, :name, unique: true
  end
end
