require 'rails_helper'
require 'factories/exchangeable_currencies_factory'
require 'factories/rate_histories_factory'

RSpec.describe RateHistoryService do
  describe 'find_recent_week_rate' do
    it 'returns the last weeks rate' do
      today = Date.today
      currency1 = FactoryBot.create(:exchangeable_currency)
      rate1 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today)
      rate2 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-1)
      rate3 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-2)
      rate4 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-3)
      rate5 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-4)
      rate6 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-5)
      rate7 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-6)
      rate_array = [rate1, rate2, rate3, rate4, rate5, rate6, rate7]
      expect(RateHistory).to receive(:where).with(id: currency1.id, date: today).and_return(rate_array)

      results = RateHistoryService.find_recent_week_rate(today, currency1.id)
      expect(results).to eq(rate_array)
    end
  end

  describe 'count_average' do
    it 'counts average of given array of numbers' do
      array = [1, 2, 3]
      results = RateHistoryService.count_average(array)
      expect(results).to eq(2.0)
    end
  end

  describe 'seven_days_average' do
    it 'counts average of recent weeks rate' do
      today = Date.today
      currency1 = FactoryBot.create(:exchangeable_currency)
      rate1 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today)
      rate2 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-1)
      rate3 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-2)
      rate4 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-3)
      rate5 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-4)
      rate6 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-5)
      rate7 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-6)
      rate_array = [rate1, rate2, rate3, rate4, rate5, rate6, rate7]

      sum = RateHistory.where(exchangeable_currency_id: currency1.id).sum(:rate)
      expect(RateHistoryService).to receive(:find_recent_week_rate).with(today, currency1.id)
                                        .and_return(rate_array)

      results = RateHistoryService.seven_days_average(today, currency1.id)

      expect(results).to be_within(0.01).of(sum/7)
    end
  end

  describe 'count_variance' do
    it 'count variances of given array of numbers' do
      array = [1.0, 2.0, 3.45]

      result = RateHistoryService.count_variance(array)
      expect(result).to eq(2.45)
    end
  end
end
