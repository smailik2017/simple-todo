class Item < ApplicationRecord
  belongs_to :task, counter_cache: true
  belongs_to :state, counter_cache: true

  validates :name, presence: true
  validates :name, length: { minimum: 3 }
end
