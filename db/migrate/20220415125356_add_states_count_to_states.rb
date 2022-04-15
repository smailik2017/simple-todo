class AddStatesCountToStates < ActiveRecord::Migration[7.0]
  def change
    add_column :states, :tasks_count, :integer
  end
end
