# frozen_string_literal: true

module FiltersHelper
  extend Grape::API::Helpers

  def all?
    ActiveRecord::Type::Boolean.new.cast(params[:all])
  end

  def task_scope
    all? ? Task.includes(:user).all : Task.includes(:user).where(done: false)
  end

  def user_scope
    User.includes(:role).all
  end

  def role_scope
    Role.all
  end
end
