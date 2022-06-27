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

  scope :in_progress, -> { where(state_id: State.find_by(name: 'in progress').id) }


  self.per_page = 4
end
