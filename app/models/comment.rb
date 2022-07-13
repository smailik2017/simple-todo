# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  children_count   :integer          default(0), not null
#  commentable_type :string
#  content          :text
#  depth            :integer          default(0), not null
#  lft              :integer          not null
#  rgt              :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  parent_id        :integer
#  user_id          :bigint
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_parent_id    (parent_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  after_touch do
    Rails.logger.info '#######################################'
    Rails.logger.info "### #{updated_at} ###"
    Rails.logger.info '#######################################'
  end

  belongs_to :user, counter_cache: true
  belongs_to :commentable, polymorphic: true

  # acts_as_nested_set
  belongs_to :parent, class_name: 'Comment'
  has_many  :children,
            class_name: 'Comment',
            foreign_key: :parent_id,
            dependent: :destroy
  
end
