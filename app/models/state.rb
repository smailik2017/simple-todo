class State < ApplicationRecord
  has_many :tasks
  has_many :items

  validates :name, uniqueness: true
end
