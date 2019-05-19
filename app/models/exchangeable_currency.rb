class ExchangeableCurrency < ApplicationRecord
  validates :from, presence: true, uniqueness: { scope: :to }
  validates :to, presence: true
  has_many :rate_histories
end
