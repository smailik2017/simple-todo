# frozen_string_literal: true

class TasksController < ApplicationController
  include Commentable
  
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    per_page = Task.per_page
    scope = policy_scope(Task)
    scope_count = scope.count
    total_pages = scope_count / per_page + ((scope_count % per_page).positive? ? 1 : 0)
    page = params[:page] ||= 1
    page = 1 if page.to_i < 1
    page = total_pages if page.to_i > total_pages

    @tasks = scope.paginate(page: page, per_page: per_page)

    Rack::MiniProfiler.step('Загрузка всех событий') do
      @all = Task.all
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show 
    authorize @task
    @comments = sort_comments(@task.comments.order(:created_at))
    # @comments = @task.comments.root.self_and_descendants.order(:lft)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.create(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: 'Task was successfully created.' }
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
        format.html { redirect_to task_url(@task), notice: 'Task was successfully updated.' }
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
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = policy_scope(Task.with_attached_files).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :description, :deadline, :state_id, :user_id, files: [])
  end

  def sort_comments(comments, id = nil, level = 0, result = [])
    comment = comments.find { |c| id ? c.id == id : c.parent_id == nil }
    return unless comment
    result << {
                comment: comment,
                level: level
              }
    comments.select { |c| c.parent_id == comment.id }
            .each { |c| sort_comments(comments, c.id, level + 1, result) }
    result
  end

end
