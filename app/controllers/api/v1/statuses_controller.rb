class Api::V1::StatusesController < ApplicationController
  before_action :get_status, only: [ :edit, :update]
  def index
    statuses = @current_user.statuses
    render json: {records: statuses.to_a}, status: :ok
  end

  def create
    status = @current_user.statuses.new(status_params)
    if status.save
      render json: {message: "Status successfully created", status: status}, status: :created
    else
      render json: {error: status.errors.messages}, status: :unprocessable_entity
    end
  end

  def new
    render json: {status: Status.new}, status: :ok
  end

  def edit
    if @status.present?
      render json: {status: @status}, status: :ok
    else
      render json: {error: "Status not found"}, status: :unprocessable_entity
    end
  end

  def update
    if @status.present?
      @status.assign_attributes(status_params)
      if @status.save
        render json: {message: "Status successfully updated", status: @status}, status: :ok
      else
        render json: {error: @status.errors.messages}, status: :unprocessable_entity
      end
    else
      render json: {error: "Status not found"}, status: :unprocessable_entity
    end
  end

  private

  def get_status
    @status = @current_user.statuses.find_by(params[:id])
  end

  def status_params
    params.require(:status).permit(:name, :color)
  end
end
