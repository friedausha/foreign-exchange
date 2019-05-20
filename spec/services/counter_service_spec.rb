require 'rails_helper'
RSpec.describe CounterService do
  let(:service) { CounterService }
  describe 'count_average' do
    it 'counts average of given array of numbers' do
      array = [1, 2, 3]
      results = service.count_average(array)
      expect(results).to eq(2.0)
    end
  end

  describe 'count_variance' do
    it 'count variances of given array of numbers' do
      array = [1.0, 2.0, 3.45]

      result = service.count_variance(array)
      expect(result).to eq(2.45)
    end
  end
end