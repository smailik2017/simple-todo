class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = policy_scope(Task)
  end

  def show
    authorize @task
  end

  def update
    authorize @task
  end

  def destroy
    authorize @task
  end
end
