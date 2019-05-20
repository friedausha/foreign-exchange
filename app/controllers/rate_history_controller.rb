class RateHistoryController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    service = RateHistoryService.new(date: params[:date], exchangeable_currency_id: params[:exchangeable_currency_id])
    render json: service.create(params[:rate])
  end

  def show
    render json: RateHistoryService.new(date: Date.today, exchangeable_currency_id: params[:id]).show
  end

  def index
    currencies = ExchangeableCurrency.all
    result = []
    currencies.each do |currency|
      service = RateHistoryService.new(date: params[:date], exchangeable_currency_id: currency.id)
      result.push({currency: currency, average: service.seven_days_average})
    end
    render json: result
  end
end
