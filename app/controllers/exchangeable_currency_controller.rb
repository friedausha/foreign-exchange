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
    render json: current_currency, status: :ok
  end

  def create
    render json: ExchangeableCurrency.create(currency_params), status: :ok
  end

  def destroy
    currency = current_currency
    currency.destroy
    render json: { status: 200 }
  end

  def update
    currency = current_currency
    currency.update_attributes(currency_params)
    render json: current_currency, status: :ok
  end

  private
  def currency_params
    params.require(:exchangeable_currency).permit(:from, :to)
  end

  def current_currency
    ExchangeableCurrency.find(params[:id])
  end

  def filtering_params
    params.slice(ExchangeableCurrency.column_names)
  end
end
