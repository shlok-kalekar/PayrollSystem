# frozen_string_literal: true

class LeavesArrayCalculator
  attr_accessor :leaves_arr

  def initialize(leaves_arr)
    @leaves_arr = leaves_arr
  end

  # trying to calculate sum
  def calculate_sum
    @leave_sum = @leaves_arr.inject(0) { |sum, hash| sum + hash[:leave_duration] }
    @leave_sum
  end
end
