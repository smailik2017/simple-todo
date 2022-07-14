class Services::Users::MaxTasks::Name
  include Callable
  extend Dry::Initializer

  param :max_count, default: proc { 3 }
  
  def call
    Queries::Users::MaxTasks.call(max_count).pluck(:name)
  end
  
end
