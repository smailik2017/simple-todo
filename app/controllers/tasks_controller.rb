class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = policy_scope(Task)
  end

  def show
    authorize @event
  end

  def update
    authorize @event
  end

  def destroy
    authorize @event
  end
end
