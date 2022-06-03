class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :page_by_page, only: :index


  # GET /tasks or /tasks.json
  def index
    # @tasks = policy_scope(Task)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      # @task = Task.find(params[:id])
      @task = policy_scope(Task).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      # params.fetch(:task, {})
      params.require(:task).permit(:name, :description, :deadline)
    end

    def page_by_page
      per_page = Task.paginates_per 5
      # tasks = policy_scope(Task, policy_scope_class: TaskPolicy::Scope).all
      tasks = policy_scope(Task)

      tasks_count = tasks.count
      @total_pages = tasks_count / per_page + (tasks_count % per_page > 0 ? 1 : 0)
      @current_page = params[:page].nil? ? 0 : params[:page]

      redirect_to tasks_path if @current_page.to_i > @total_pages.to_i || @current_page.to_i < 0

      @tasks = tasks.page(@current_page)

    end

end
