class RateHistoryService
    def initialize(date:, exchangeable_currency_id:)
      @date = date.to_date
      @exchangeable_currency_id = exchangeable_currency_id
    end

    def seven_days_rate
      @seven_days_rate ||= RateHistory.where(exchangeable_currency_id: @exchangeable_currency_id, date: @date-6..@date).to_a
    end

    def seven_days_rate_array
      @seven_days_rate_array ||= seven_days_rate.map{ |rate| rate.rate }
    end

    def seven_days_average
      @seven_days_average ||= begin
        seven_days_rate.size == 7 ? CounterService.count_average(seven_days_rate_array) : self.class.insufficient_data
      end
    end

    def seven_days_variance
      @seven_days_variance ||= begin 
seven_days_rate_array.size > 0 ? 			CounterService.count_variance(seven_days_rate_array) : 0
end
    end

    def self.insufficient_data
      'Insuficient data'
    end

    def create(rate)
      currency = ExchangeableCurrencyService.new(@exchangeable_currency_id).current_currency
      unless currency.present?
        ExchangeableCurrencyService.not_found
      end
      RateHistory.create(date: @date, exchangeable_currency_id: @exchangeable_currency_id, rate: rate)
    end

    def show
      currency = ExchangeableCurrencyService.new(@exchangeable_currency_id).current_currency
      unless currency.present?
       return ExchangeableCurrencyService.not_found
      end
      { rates: seven_days_rate, average: seven_days_average, variance: seven_days_variance }
    end
end
