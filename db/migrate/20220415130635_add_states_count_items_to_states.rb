class AddStatesCountItemsToStates < ActiveRecord::Migration[7.0]
  def change
    add_column :states, :items_count, :integer
  end
end
