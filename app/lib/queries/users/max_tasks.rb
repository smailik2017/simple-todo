class Queries::Users::MaxTasks
  include Callable
  extend Dry::Initializer

  param :max_count, default: proc { 3 }
  
  def call
    User.where(id: user_ids)
  end
  
  private
  
  def user_ids
    Task.group(:user_id)
        .count
        .max_by(max_count) { |_user_id, count| count }
        .map { |user_id, _count| user_id }
  end
end
