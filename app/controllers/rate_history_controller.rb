class RateHistoryController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: RateHistory.where(date: params[:date])
  end

  def show
    render json: current_rate, status: :ok
  end

  def create
    render json: RateHistory.create!(rate_params), status: :ok
  end

  def destroy
    rate = current_rate
    rate.destroy!
    render json: { status: 200 }
  end

  def update
    rate = current_rate
    rate.update(rate_params)
    render json: current_rate, status: :ok
  end

  private
  def rate_params
    params.require(:rate_history).permit(:from, :to)
  end

  def current_rate
    RateHistory.find(params[:id]).where(date: params[:date])
  end
end
