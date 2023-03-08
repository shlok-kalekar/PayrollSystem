class LeavesChecker

  attr_accessor :active_leaves, :attendance

  def initialize(active_leaves, attendance)
    @leave = active_leaves
    @attendance = attendance
  end

  def  check_for_months

    attendance_date = @attendance.attendance_month.to_date
    attendance_month = attendance_date.month.to_i
    month_leave = @leave.where("(start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?)", attendance_date.beginning_of_month,
    attendance_date.end_of_month, attendance_date.beginning_of_month,attendance_date.end_of_month)
    total_duration = 0
    wdays = [0,6] #weekend days by numbers on week
    month_leave.each do |x|
      leave_duration = 0
      if x.start_date.to_date.month < attendance_month && x.end_date.to_date.month == attendance_month
        start_date = attendance_date.beginning_of_month
        end_date = x.end_date.to_date
      elsif x.start_date.to_date.month == attendance_month && x.end_date.to_date.month > attendance_month
        end_date = attendance_date.end_of_month
        start_date = x.start_date.to_date
      elsif x.start_date.to_date.month == attendance_month && x.end_date.to_date.month == attendance_month
        start_date = x.start_date.to_date
        end_date = x.end_date.to_date
      else
        render json: {message: "Enter valid dates"}
      end
      leave_duration = (((start_date..end_date).reject { |d| wdays.include? d.wday}).count)
      total_duration = total_duration + leave_duration
    end
    total_duration
  end

end