class AttendancesController < ApplicationController

  before_action :set_attendance, only: %i[show update destroy]
  before_action :set_extra_fields, only: %i[create]

  def index
    @attendance = Attendance.all.as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    render json: @attendance,
            status: :ok  
  end

  def create
    if @attendance.save!
      render json: {message: "Successfully added data"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def show
    if @attendance
      render json: @attendance,
              status: :ok,
              except: %i[created_at updated_at],
              include: ["user" => {:only => :full_name}]
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end
  end

  def update
    if @attendance.update(update_params)
      render json: {message: "Successfully updated data!"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def destroy
    if @attendance.destroy
      render json: {message: "Successfully deleted data!"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def find_emp_attendance
    @user = User.find(params[:id])
    @attendance = Attendance.all.where(user_id: @user.id).as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    render json: @attendance,
            status: :ok
  end

  def set_extra_fields
    @attendance = Attendance.new(attendance_params)
    if !@attendance.tot_work_days
      $work_days = calculate_work_days
      @attendance.tot_work_days = $work_days
    end
    @attendance.attend_rate = calculate_attend_rate
    @attendance
  end

  def calculate_work_days #trying to calculate work days
    date_value = attendance_params[:current_month].to_date
    d1 = Date.new( date_value.year, date_value.mon, 1) #first day of month\period
    d2 = Date.new( date_value.year, date_value.mon, -1) #end day of month\period
    wdays = [0,6] #weekend days by numbers on week
    weekdays = ((d1..d2).reject { |d| wdays.include? d.wday}).count #Day.wday number day in week
  end

  def calculate_attend_rate
    unpaid_value = attendance_params[:unpaid_leaves].to_f
    attend_rate = (($work_days - unpaid_value)/($work_days)) * 100
  end

  private
  def attendance_params
    params.require(:attendance).permit(:current_month, :tot_work_days, :unpaid_leaves, :user_id)
  end

  def update_params
    params.require(:attendance).permit(:current_month, :tot_work_days, :unpaid_leaves)
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

end
