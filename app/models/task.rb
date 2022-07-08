# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  deadline    :date
#  description :string
#  done        :boolean
#  items_count :integer
#  name        :string
#  state_flag  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  state_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_name      (name) UNIQUE
#  index_tasks_on_state_id  (state_id)
#  index_tasks_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (state_id => states.id)
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  include AASM

  enum state_flag: {
    novel: 10,
    at_work: 20,
    not_completed: 30,
    postponed: 40,
    completed: 50
  }

  aasm :column => 'state_flag', whiny_transitions: false do
    state :novel, initial: true, display: I18n.t('task.state_flag.novel')
    state :at_work, display: I18n.t('task.state_flag.at_work')
    state :not_completed, display: I18n.t('task.state_flag.not_completed')
    state :postponed, display: I18n.t('task.state_flag.postponed')
    state :completed, display: I18n.t('task.state_flag.completed')

    ## Новая задача
    # Новая задача взята в работу
    event :novel_at_work do
      transitions from: :novel, to: :at_work
    end

    # Новая задача отложена
    event :novel_postponed do
      transitions from: :novel, to: :postponed
    end

    ## Задача 'в работе'
    # Задача 'в работе' отложена
    event :at_work_postponed do
      transitions from: :at_work, to: :postponed
    end

    # Задача 'в работе' выполнена
    event :at_work_completed do
      transitions from: :at_work, to: :completed
    end

    # Задача 'в работе' не выполнена
    event :at_work_not_completed do
      transitions from: :at_work, to: :not_completed
    end

    ## Отложенная задача
    # Отложенная задача взята в работу
    event :postponed_at_work do
      transitions from: :postponed, to: :at_work
    end

    # Отложенная задача не выполнена
    event :postponed_not_completed do
      transitions from: :postponed, to: :not_completed
    end

    # Отложенная задача выполнена
    event :postponed_completed do
      transitions from: :postponed, to: :completed
    end

    ## Не выполненная задача
    # Не выполненная задача взята в работу
    event :not_completed_at_work do
      transitions from: :not_completed, to: :at_work
    end

    ## Выполненная задача
    # Выполненная задача взята в работу
    event :completed_at_work do
      transitions from: :completed, to: :at_work
    end

  end


  belongs_to :user, counter_cache: true
  belongs_to :state, counter_cache: true

  has_many :items, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commentators, through: :comments, source: :user

  has_many_attached :files

  validates :name, presence: true
  validates :name, length: { maximium: 16, minimum: 3 }
  validates :name, uniqueness: true

  validates :description, presence: true
  validates :description, length: { minimum: 3 }

  scope :in_progress, -> { where(state_id: State.find_by(name: 'in progress').id) }


  self.per_page = 4
end
