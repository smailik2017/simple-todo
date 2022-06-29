# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean
#  comments_count         :integer
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  settings               :jsonb
#  sign_in_count          :integer          default(0), not null
#  state                  :integer
#  tasks_count            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint           not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord
  self.per_page = 3
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
  before_destroy do
    Rails.logger.info "### Собираемся удалить пользователя #{name} ###"
  end

  after_destroy do
    Rails.logger.info "### Пользователь #{name} удален ###"
  end

  before_validation :normalize_name, on: %i[create update]
  before_validation :normalize_email, if: proc { |u| u.email.present? }
  before_validation :set_default_role

  belongs_to :role, counter_cache: true

  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :commented_tasks,
           through: :comments,
           source: :commentable,
           source_type: :Task
  has_many  :commented_users,
            through: :comments,
            source: :commentable,
            source_type: :User

  has_one_attached  :avatar

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

  Role.find_each do |role|
    define_method "#{role.code}?" do
      role_id == role.id
    end
  end

  def active_for_authentication?
    super && active?
  end

  def description
    "#{name} #{email}"
  end

  # def attributes
  #   super.filter{ |k, _v| %w[name email].include? k }.merge(description: description)
  # end

  private

  def normalize_name
    self.name = name.downcase.titleize
  end

  def normalize_email
    self.email = email
  end

  def set_default_role
    self.role_id = Role.where(code: 'default')[0].id if role_id.nil? || Role.find(role_id).nil?
  end
end
