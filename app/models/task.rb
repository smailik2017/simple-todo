class Task < ApplicationRecord
  belongs_to :user
  belongs_to :state

  has_many :items

  validates :name, presence: true
  validates :name, length: { maximium: 16, minimum: 3 }
  validates :name, uniqueness: true
  
  validates :description, presence: true
  validates :description, length: { minimum: 3 }

end
