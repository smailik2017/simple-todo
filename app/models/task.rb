class Task < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :state, counter_cache: true

  has_many :items, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commentators, through: :comments, source: :user

  validates :name, presence: true
  validates :name, length: { maximium: 16, minimum: 3 }
  validates :name, uniqueness: true
  
  validates :description, presence: true
  validates :description, length: { minimum: 3 }

  self.per_page = 4
end
