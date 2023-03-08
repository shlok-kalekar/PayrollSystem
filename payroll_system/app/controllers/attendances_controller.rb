class AttendancesController < ApplicationController

  load_and_authorize_resource

  before_action :set_attendance, only: %i[show update destroy]
  before_action :set_extra_fields, only: %i[create]

  def index
    @attendance = Attendance.all.as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    if @attendance
      render json: @attendance,
              status: :ok
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end
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

  def find_attendance
    @user = User.find(current_user.id)
    @attendance = Attendance.all.where(user_id: @user.id).as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    render json: @attendance,
            status: :ok
  end

  def set_extra_fields
    attendance = Attendance.new(attendance_params)
    user = User.find(params[:attendance][:user_id])

    if !attendance.tot_work_days
      @work_days = AttendanceCalculator.new(attendance).calculate_work_days
      attendance.tot_work_days = @work_days
    end

    active_leaves = user.leave_balances.where(leave_status: "Approved")
    unpaid_leaves = active_leaves.where(leave_type: "Unpaid")
    paid_leaves = active_leaves.where(leave_type: "Paid")
    leave = {}
    unpaid_excess_value = 0

    paid_initial_value = LeavesChecker.new(paid_leaves, attendance).check_for_months
    unpaid_intial_value = LeavesChecker.new(unpaid_leaves, attendance).check_for_months

    @tot_paid_leaves = user.tot_paid_leaves

    if @tot_paid_leaves >= paid_initial_value
      @tot_paid_leaves -= paid_initial_value
    elsif @tot_paid_leaves < paid_initial_value
      unpaid_excess_value = paid_initial_value - @tot_paid_leaves
      @tot_paid_leaves = 0
    end

    user.tot_paid_leaves = @tot_paid_leaves
    user.save!

    unpaid_final_value = unpaid_excess_value + unpaid_intial_value
    attendance.unpaid_leaves = unpaid_final_value

    attendance.attend_rate = AttendanceCalculator.new(attendance).calculate_attend_rate
    @attendance = attendance
  end

  private
  def attendance_params
    params.require(:attendance).permit(:attendance_month, :tot_work_days, :user_id) # :unpaid_leaves
  end

  def update_params
    params.require(:attendance).permit(:attendance_month, :tot_work_days, :unpaid_leaves)
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

end
