# eMail #
class Services::Users::MaxTasks::Email
  include Callable
  extend Dry::Initializer

  param :max_count, default: proc { 3 }

  def call
    Queries::Users::MaxTasks.call(max_count).pluck(:email)
  end
  
end
