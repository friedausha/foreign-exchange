require 'rails_helper'
FactoryBot.define do
  factory :rate_history do
    date { Faker::Date.between(1.year.ago, Date.today) }
    rate { Random.rand(0.1..1000.00) }
  end
end