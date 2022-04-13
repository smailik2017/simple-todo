class User < ApplicationRecord
  belongs_to :role
  has_many :tasks

  validates :name, presence: true
  validates :name, length: { maximium: 16, minimum: 2 }
  validates :name, uniqueness: true

  scope :admins, -> { where(role_id: Role.find_by(name: 'admin').id) }
  scope :users, -> { where(role_id: Role.find_by(name: 'user').id) }

  store :settings, coder: JSON
  store_accessor :settings, :per_page, :time_zone, :show_help

  enum state: {
    created: 1,
    email_verified: 2,
    studied: 3,
    actived: 4,
    disabled: 5
  } 

end
