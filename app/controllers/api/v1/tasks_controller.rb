class Api::V1::TasksController < ApplicationController
  def create
    render json:{message: "Task successfully created"}, status: :created
  end
end
