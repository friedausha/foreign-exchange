require 'rails_helper'
require 'factories/exchangeable_currencies_factory'
require 'factories/rate_histories_factory'

RSpec.describe RateHistoryService do
  let(:currency1) { FactoryBot.create(:exchangeable_currency) }
  let(:today) { Date.today}
  let(:service) { RateHistoryService.new(date: today, exchangeable_currency_id: currency1.id) }

  describe 'seven_days_rate' do
    it 'returns the last weeks rate' do
      rate1 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today)
      rate2 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-1)
      rate3 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-2)
      rate4 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-3)
      rate5 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-4)
      rate6 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-5)
      rate7 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-6)
      rate_array = [rate1, rate2, rate3, rate4, rate5, rate6, rate7]
      expect(RateHistory).to receive(:where).with(exchangeable_currency_id: currency1.id, date: today-6..today)
                                 .and_return(rate_array)

      results = service.seven_days_rate
      expect(results).to eq(rate_array)
    end
  end

  describe 'seven_days_average' do
    it 'counts average of recent weeks rate' do
      rate1 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today)
      rate2 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-1)
      rate3 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-2)
      rate4 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-3)
      rate5 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-4)
      rate6 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-5)
      rate7 = FactoryBot.create(:rate_history, exchangeable_currency_id: currency1.id, date: today-6)
      rate_array = [rate1, rate2, rate3, rate4, rate5, rate6, rate7]

      sum = RateHistory.where(exchangeable_currency_id: currency1.id).sum(:rate)
      expect(service).to receive(:seven_days_rate).at_least(:once).and_return(rate_array)

      results = service.seven_days_average

      expect(results).to be_within(0.01).of(sum/7)
    end
  end


end
