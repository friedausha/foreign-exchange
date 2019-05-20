require 'rails_helper'
require 'factories/exchangeable_currencies_factory'
require 'factories/rate_histories_factory'
RSpec.describe RateHistoryController do
  let(:today) { Date.today }
  let(:currency1) { FactoryBot.create(:exchangeable_currency) }
  let(:currency2) { FactoryBot.create(:exchangeable_currency) }

  let(:rate1) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today) }
  let(:rate2) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-1) }
  let(:rate3) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-2) }
  let(:rate4) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-3) }
  let(:rate5) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-4) }
  let(:rate6) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-5) }
  let(:rate7) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-6) }
  let(:rate8) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-7) }

  let(:rate9) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency2.id, date: today) }
  let(:rate10) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency2.id, date: today-1) }
  let(:rate11) { FactoryBot.create(:rate_history, exchangeable_currency_id: currency2.id, date: today-2) }

  describe 'GET index' do
    it 'returns rate from certain date' do
      rate_sum = rate1.rate + rate2.rate + rate3.rate + rate4.rate + rate5.rate + rate6.rate + rate7.rate
      expected_result = [{currency: JSON.parse(currency1.to_json), average: (rate_sum/7).round(3)},
                         {currency: JSON.parse(currency2.to_json), average: 'Insuficient data'}]
      expect(ExchangeableCurrency).to receive(:all).and_return([currency1, currency2])
      get 'index', params: {date: today}
      expect(JSON.parse(response.body)).to eq(JSON.parse(expected_result.to_json))
    end
  end

  describe 'POST create' do
    it 'return the new rate' do
      rate = FactoryBot.create(:rate_history, exchangeable_currency_id: currency2.id)
      post :create, params: { exchangeable_currency_id: currency2.id, date: rate.date, rate: rate.rate }

      expect(JSON.parse(response.body)['rate']).to eq(JSON.parse(rate.to_json)['rate'])
      expect(JSON.parse(response.body)['date']).to eq(JSON.parse(rate.to_json)['date'])
      expect(JSON.parse(response.body)['exchangeable_currency_id']).to eq(JSON.parse(rate.to_json)['exchangeable_currency_id'])
    end
  end

  describe 'GET show' do
    it 'returns detail and average and variance of mentioned currency' do
      rate_array = [rate1.rate, rate2.rate, rate3.rate, rate4.rate, rate5.rate, rate6.rate, rate7.rate]
      rate_sum = rate1.rate + rate2.rate + rate3.rate + rate4.rate + rate5.rate + rate6.rate + rate7.rate
      expect(ExchangeableCurrency).to receive(:find_by).with(id: currency1.id.to_s).and_return(currency1)

      get :show, params: {id: currency1.id }
      expect(JSON.parse(response.body)['variance']).to eq((rate_array.max - rate_array.min).round(3))
      expect(JSON.parse(response.body)['average']).to eq((rate_sum/7).round(3))
    end

    context 'no currency found' do
      it 'returns no data' do
        get :show, params: {id: currency1.id+1000 }

        expect(JSON.parse(response.body)).to eq(JSON.parse({ status: 404, message: 'Currency not found'}.to_json))
      end
    end
  end
end