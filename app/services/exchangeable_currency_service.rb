class ExchangeableCurrencyService
    def initialize(id)
      @id = id
    end

    def current_currency
      @current_currency ||= ExchangeableCurrency.find(@id)
    end

    def currency_found?
      current_currency.present? ? current_currency : not_found
    end

    def self.not_found
      { status: 404, message: 'Currency not found'}
    end
end
