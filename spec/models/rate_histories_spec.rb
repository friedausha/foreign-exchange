require 'rails_helper'
RSpec.describe RateHistory, type: :model do
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:rate) }
  it { should belong_to(:exchangeable_currency) }
end
