require 'rails_helper'

RSpec.describe ExchangeableCurrency, type: :model do
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }

  it { should validate_uniqueness_of(:from).scoped_to(:to) }
  it { should have_many(:rate_histories) }
end