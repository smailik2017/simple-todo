class State < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, uniqueness: true
end
