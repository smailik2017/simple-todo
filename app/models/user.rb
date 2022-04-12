class User < ApplicationRecord
  belongs_to :role
  validates :name, presence: true
  validates :name, length: { maximium: 16, minimum: 2 }
  validates :name, uniqueness: true

  scope :admins, -> { where(role_id: Role.find_by(name: 'admin').id) }
  scope :users, -> { where(role_id: Role.find_by(name: 'user').id) }

  store :settings, coder: JSON
  store_accessor :settings, :per_page, :time_zone, :show_help

  enum state: %i[created email_verified studied actived disabled]

end
