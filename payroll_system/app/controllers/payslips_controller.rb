class PayslipsController < ApplicationController

  load_and_authorize_resource

  before_action :set_payslips, only: %i[show destroy]
  before_action :set_extra_fields, only: %i[create]

  def index
    @payslip = Payslip.all.as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    if @payslip
      render json: @payslip,
              status: :ok
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end
  end

  def create
    if @payslip.save!
      render json: {message: "Successfully added data"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def show
    if @payslip
      render json: @payslip,
              status: :ok,
              except: %i[created_at updated_at],
              include: ["user" => {:only => :full_name}]
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end
  end

  def destroy
    if @payslip.destroy
      render json: {message: "Successfully deleted data!"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def find_payslips
    @user = User.find(current_user.id)
    @payslip = Payslip.all.where(user_id: @user.id).as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    render json: @payslip,
            status: :ok
  end

  def set_extra_fields
    payslip = Payslip.new(payslip_params)
    user = User.find(params[:payslip][:user_id])
    attend = user.attendances.find_by(attendance_month: params[:payslip][:slip_month])
    sal_attend = user.salaries.find_by(salary_month: params[:payslip][:slip_month])
    if attend && sal_attend
      attend_arr = AttendanceCut.new(attend, sal_attend).calculate_attend_cut
    else
      raise "Attendance and Salary required for the current month"
    end
    @rem_sal = attend_arr[0]
    @att_cut = attend_arr[1]
    payslip.remaining_salary = @rem_sal
    payslip.attendance_cut = @att_cut

    deductions_array = {}
    slip_year = params[:payslip][:slip_month].to_date.year.to_i
    sal_tax = user.salaries.find_by(salary_month: params[:payslip][:slip_month])
    deductions_array = user.tax_deductions.where("cast(strftime('%Y', financial_year) as int) = ?", slip_year)
    @tot_tax = TaxCalculator.new(sal_tax, deductions_array).calculate_tax
    payslip.tot_tax = @tot_tax
    payslip.payable_salary = @rem_sal - @tot_tax

    @payslip = payslip
  end

  private

  def payslip_params
    params.require(:payslip).permit(:slip_month, :user_id)
  end

  def set_payslips
    @payslip = Payslip.find(params[:id])
  end

end
