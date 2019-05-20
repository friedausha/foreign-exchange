class ExchangeableCurrencyController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    unless params[:from].present?
      currency = ExchangeableCurrency.all
    else
      currency = ExchangeableCurrency.where(from: params[:from]) if params[:from].present?
    end
    render json: currency
  end

  def show
    render json: ExchangeableCurrencyService.new(params[:id]).currency_found?
  end

  def create
    render json: ExchangeableCurrency.create(currency_params), status: :ok
  end

  def destroy
    currency = ExchangeableCurrencyService.new(params[:id]).current_currency
    if currency.present?
      currency.destroy
      render json: { status: 200 }
    else
      ExchangeableCurrencyService.not_found
    end
  end

  def update
    currency = ExchangeableCurrencyService.new(params[:id]).current_currency
    if currency.present?
      currency.update_attributes(currency_params)
      render json: currency, status: :ok
    else
      ExchangeableCurrencyService.not_found
    end
  end

  private
  def currency_params
    params.require(:exchangeable_currency).permit(:from, :to)
  end

  def filtering_params
    params.slice(ExchangeableCurrency.column_names)
  end
end
