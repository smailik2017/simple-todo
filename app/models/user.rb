class User < ApplicationRecord
  belongs_to :role
  validates :name, presence: true
  validates :name, length: { maximium: 16, minimum: 2 }
  validates :name, uniqueness: true
end
