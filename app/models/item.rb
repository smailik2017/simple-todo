# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  deadline   :date
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state_id   :bigint           not null
#  task_id    :bigint           not null
#
# Indexes
#
#  index_items_on_state_id  (state_id)
#  index_items_on_task_id   (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (state_id => states.id)
#  fk_rails_...  (task_id => tasks.id)
#
class Item < ApplicationRecord
  belongs_to :task, counter_cache: true
  belongs_to :state, counter_cache: true

  validates :name, presence: true
  validates :name, length: { minimum: 3 }
end
