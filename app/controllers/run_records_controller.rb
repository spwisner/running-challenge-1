class RunRecordsController < ApplicationController
  before_action :set_run_record, only: [:show, :update, :destroy]

  # GET /run_records
  def index
    @run_records = RunRecord.all

    render json: @run_records
  end

  # GET /run_records/1
  def show
    render json: @run_record
  end

  # POST /run_recordsSET
  def create
    @run_record = RunRecord.new(run_record_params)
    @run_record.pace = (@run_record.time/@run_record.distance).round(2)
    p @run_record.finished
    if @run_record.finished.nil?
      @run_record.finished = false
    end

    if @run_record.save
      render json: @run_record, status: :created, location: @run_record
    else
      render json: @run_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /run_records/1
  def update
    @run_record = RunRecord.find(params[:id])
    params[:run_record][:pace] = (params[:run_record][:time].to_f/params[:run_record][:distance].to_f).round(2)

    if @run_record.update(params.require(:run_record).permit(:distance, :time, :pace, :finished))
      render json: @run_record
    else
      render json: @run_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /run_records/1
  def destroy
    @run_record.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run_record
      @run_record = RunRecord.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def run_record_params
      if params[:run_record].values_at(:pace) != [""] and (params[:run_record].has_key?(:pace) == true)
        ActionController::Parameters.action_on_unpermitted_parameters = :raise
      else
        ActionController::Parameters.action_on_unpermitted_parameters = :log
      end
      params[:run_record].require([:date, :difficulty, :distance, :time])
      params.require(:run_record).permit(:date, :difficulty, :distance, :time, :notes, :finished)
    end
end