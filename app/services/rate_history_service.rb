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
      recent_rates_array = recent_rates.(select: 'rate').map(&rate)
      count_average(recent_rates_array)
    end

    def count_variance(numbers)
      numbers.values.map(&:to_i).max - numbers.values.map(&:to_i).min
    end
  end
end
