# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id          :bigint           not null, primary key
#  items_count :integer
#  name        :string
#  tasks_count :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_states_on_name  (name) UNIQUE
#
class State < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, uniqueness: true
end
