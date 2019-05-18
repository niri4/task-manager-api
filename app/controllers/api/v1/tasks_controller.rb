class Api::V1::TasksController < ApplicationController
  before_action :get_task, only: [:show, :edit, :update, :destroy]
  def index
    task = @current_user.tasks
    task_with_archieve = @current_user.tasks.only_deleted
    render json: {records: task.to_a, archive_record: task_with_archieve.to_a}, status: :ok
  end

  def create
    task = @current_user.tasks.new(task_params)
    if task.save
      render json: {message: "Task successfully created", task: task}, status: :created
    else
      render json: {error: task.errors.messages}, status: :unprocessable_entity
    end
  end

  def show
    if @task.present?
      render json: {task: @task}, status: :ok
    else
      render json: {error: "Task not found"}, status: :unprocessable_entity
    end
  end

  def new
    render json: {task: Task.new}, status: :ok
  end

  def edit
    if @task.present?
      render json: {task: @task}, status: :ok
    else
      render json: {error: "Task not found"}, status: :unprocessable_entity
    end
  end

  def update
    if @task.present?
      @task.assign_attributes(task_params)
      if @task.save
        render json: {message: "Task successfully updated", task: @task}, status: :ok
      else
        render json: {error: @task.errors.messages}, status: :unprocessable_entity
      end
    else
      render json: {error: "Task not found"}, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.present?
      @task.destroy
      render json: {message: "Task successfully deleted"}, status: :ok
    else
      render json: {error: "something went wrong"}, status: :unprocessable_entity
    end
  end

  private

  def get_task
    @task = @current_user.tasks.find_by(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :label_id, :status_id)
  end
end
