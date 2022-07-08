class AddStateFlagToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :state_flag, :integer, comment: 'Состояние пользователя'
  end
end
