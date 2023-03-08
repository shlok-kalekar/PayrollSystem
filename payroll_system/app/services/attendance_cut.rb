class AttendanceCut

  attr_accessor :attend, :sal

  def initialize(attend, sal)
    @attend = attend
    @sal = sal
    @attend_rate = attend['attend_rate']
    byebug
    @monthly_salary = sal['monthly_salary']
    attend_arr = Array.new
  end

  def calculate_attend_cut
    byebug
    if @attend
      byebug
      if @sal
        byebug
        @rem_sal = ((@attend_rate)/100) * @monthly_salary
        @att_cut = @monthly_salary - @rem_sal
        attend_arr = [@rem_sal, @att_cut]
        attend_arr
      else
        render json: {message: "Salary does not exist for this month"}
      end
    else
      render json: {message: "Attendance does not exist for this particular month"}
    end
  end
  
end

