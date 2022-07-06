class ChangeTrafficLightsState < ActiveRecord::Migration[7.0]
  def change
    ActiveRecord::Base.connection.truncate(:traffic_lights)
    change_column :traffic_lights,
                  :state,
                  :integer,
                  comment: 'Состояние AASM: красный, желтый, зеленый',
                  using: 'state::integer'
  end
end
