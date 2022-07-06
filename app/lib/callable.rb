module Callable
  extend ActiveSupport::Concern

  included do
    private_class_method :new
  end

  class_methods do
    def call(*args)
      new.call(*args)
    end
  end
end
