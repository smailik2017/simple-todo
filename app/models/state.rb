class State < ApplicationRecord
  validates :name, uniqueness: true
end
