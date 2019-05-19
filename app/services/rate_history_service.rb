module RateHistoryService
  class << self
    def find_recent_week_rate(date, exchangeable_currency_id)
      RateHistory.where(id: exchangeable_currency_id, date: date).to_a
    end

    def count_average(numbers)
      numbers.sum/numbers.size.to_f
    end

    def seven_days_average(date, exchangeable_currency_id)
      recent_rates = find_recent_week_rate(date, exchangeable_currency_id)
      rates_array = recent_rates.map{ |rate| rate.rate }
      count_average(rates_array)
    end

    def count_variance(numbers)
      numbers.max - numbers.min
    end
  end
end
