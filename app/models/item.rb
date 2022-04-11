class Item < ApplicationRecord
  belongs_to :task
  belongs_to :state

  validates :name, presence: true
  validates :name, length: { minimum: 3 }
end
