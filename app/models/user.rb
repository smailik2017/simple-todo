class User < ApplicationRecord
  before_destroy  do
    Rails.logger.info "### Собираемся удалить пользователя #{name} ###"
  end

  after_destroy do
    Rails.logger.info "### Пользователь #{name} удален ###"
  end

  before_validation :normalize_name, on: [ :create, :update ]
  before_validation :normalize_email, if: Proc.new { |u| u.email.present? } 

  belongs_to :role, counter_cache: true
  
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :commented_tasks, 
            through:        :comments, 
            source:         :commentable, 
            source_type:    :Task
  has_many  :commented_users,
            through:        :comments,
            source:         :commentable,
            source_type:    :User

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

  private

  def normalize_name
    self.name = name.downcase.titleize
  end

end
