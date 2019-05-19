require 'rails_helper'
FactoryBot.define do
  factory :exchangeable_currency do
    from { Faker::Currency.code }
    to  { Faker::Currency.code }
  end
end
