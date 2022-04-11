class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.date :deadline
      t.references :task, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true

      t.timestamps
    end
  end
end
