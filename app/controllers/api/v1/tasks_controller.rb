class Api::V1::TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: {message: "Task successfully created", task: @task}, status: :created
    else
      render json: {error: @task.errors.messages}, status: :unprocessable_entity
    end
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :due_date)
  end
end
