class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.date :deadline
      t.references :user, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :name, unique: true
  end
end
