class RateHistory < ApplicationRecord
  validates :date, :rate, presence: true
  belongs_to :exchangeable_currency
  scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
end
