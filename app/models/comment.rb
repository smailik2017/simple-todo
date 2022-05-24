class Comment < ApplicationRecord
  after_touch do
    Rails.logger.info '#######################################'
    Rails.logger.info "### #{updated_at} ###"
    Rails.logger.info '#######################################'
  end
  
  belongs_to :user, counter_cache: true
  belongs_to :commentable, polymorphic: true

end
