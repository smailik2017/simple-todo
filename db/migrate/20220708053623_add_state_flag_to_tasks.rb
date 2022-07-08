class AddStateFlagToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :state_flag, :integer, comment: 'Состояние задачи'
  end
end
