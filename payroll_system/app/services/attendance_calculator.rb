class AttendanceCalculator

  attr_accessor :attendance_params, :attendance

  def initialize(attendance)
    @attendance = attendance
    @attendance_month = attendance['attendance_month']
    @tot_work_days = attendance['tot_work_days']
    @unpaid_leaves = attendance['unpaid_leaves']
  end

  def calculate_work_days #trying to calculate work days
    date_value = @attendance_month.to_date
    d1 = Date.new( date_value.year, date_value.mon, 1) #first day of month\period
    d2 = Date.new( date_value.year, date_value.mon, -1) #end day of month\period
    wdays = [0,6] #weekend days by numbers on week
    weekdays = ((d1..d2).reject { |d| wdays.include? d.wday}).count #Day.wday number day in week
  end

  def calculate_attend_rate
    unpaid_value = @unpaid_leaves.to_f
    attend_rate = ((@tot_work_days - unpaid_value)/(@tot_work_days)) * 100
    attend_rate
  end

end