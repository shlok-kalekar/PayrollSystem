class LeavesArrayCalculator

  attr_accessor :leaves_arr

  def initialize(leaves_arr)
    @leaves_arr = leaves_arr
  end

  def calculate_sum #trying to calculate sum
    @leave_sum = @leaves_arr.inject(0) {|sum, hash| sum + hash[:leave_duration]}
    @leave_sum
  end

end