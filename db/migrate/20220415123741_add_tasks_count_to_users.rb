class AddTasksCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tasks_count, :integer
  end
end
