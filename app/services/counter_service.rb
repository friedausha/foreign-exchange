class CounterService

  def self.count_variance(numbers)
    (numbers.max - numbers.min).round(3)
  end

  def self.count_average(numbers)
    (numbers.sum/numbers.size.to_f).round(3)
  end
end
