class Api::V1::LabelsController < ApplicationController
  before_action :get_label, only: [ :edit, :update]
  def index
    labels = @current_user.labels
    render json: {records: labels.to_a}, status: :ok
  end

  def create
    label = @current_user.labels.new(label_params)
    if label.save
      render json: {message: "Label successfully created", label: label}, status: :created
    else
      render json: {error: label.errors.messages}, status: :unprocessable_entity
    end
  end

  def new
    render json: {label: Label.new}, status: :ok
  end

  def edit
    if @label.present?
      render json: {label: @label}, status: :ok
    else
      render json: {error: "Label not found"}, status: :unprocessable_entity
    end
  end

  def update
    if @label.present?
      @label.assign_attributes(label_params)
      if @label.save
        render json: {message: "Label successfully updated", label: @label}, status: :ok
      else
        render json: {error: @label.errors.messages}, status: :unprocessable_entity
      end
    else
      render json: {error: "Label not found"}, status: :unprocessable_entity
    end
  end

  private

  def get_label
    @label = @current_user.labels.find_by(params[:id])
  end

  def label_params
    params.require(:label).permit(:name, :color)
  end
end
