class PayslipsController < ApplicationController

  before_action :set_payslips, only: %i[show destroy]
  before_action :set_extra_fields, only: %i[create]

  def index
    @payslip = Payslip.all.as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    byebug
    render json: @payslip,
            status: :ok  
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

  def set_extra_fields
    @payslip = Payslip.new(payslip_params)
    byebug
    calculate_attend_tax
    @payslip.taxable_salary = $tax_sal
    @payslip.attendance_deductible = $att_tax
    calculate_tax
    @payslip.tot_tax = $tot_tax
    @payslip.payable_salary = $tax_sal - $tot_tax
    @payslip
  end

  private

  def calculate_attend_tax
    @user = User.find(params[:payslip][:user_id])
    @attend = @user.attendances.find_by(current_month: params[:payslip][:slip_month])
    @sal = @user.salaries.find_by(salary_date: params[:payslip][:slip_month])
    byebug
    if @attend
      byebug
      if @sal
        byebug
        $tax_sal = ((@attend.attend_rate)/100) * @sal.total_salary
        $att_tax = @sal.total_salary - $tax_sal
        byebug
      else
        render json: {message: "Salary does not exist for this month"}
      end
    else
      render json: {message: "Attendance does not exist for this particular month"}
    end
  end

  def calculate_tax
    @user = User.find(params[:payslip][:user_id])
    @slip_time = {}
    slip_year = params[:payslip][:slip_month].to_date.year.to_i
    byebug
    @sal = @user.salaries.find_by(salary_date: params[:payslip][:slip_month])
    byebug
    @slip_time = @user.tax_deductions.where("cast(strftime('%Y', financial_year) as int) = ?", slip_year)
    if @slip_time.empty?
      byebug
      $deduction = 0
    else
      byebug
      calculate_deduction
    end
    $tentative_package = (@sal.total_salary * 12)
    $tax_bracket = $tentative_package - $deduction
    tax = check_tax_bracket
    $tot_tax = tax / 12
  end

  def calculate_deduction
    byebug
    if @slip_time.exists?{|element| element[:deduct_type] == "NPS"}
      deduct_limit = 200000
    else
      deduct_limit = 150000
    end
    $deduction = @slip_time.inject(0) {|sum, hash| sum + hash[:amount_deduct]}
    byebug
    if $deduction >= deduct_limit
      byebug
      $deduction = deduct_limit
    end
    $deduction
  end

  def check_tax_bracket
    if $tax_bracket > 0 && $tax_bracket <= 300000
      tax = 0
    elsif $tax_bracket > 300000 && $tax_bracket <= 600000
      tax = ($tax_bracket * 5) / 100
    elsif $tax_bracket > 600000 && $tax_bracket <= 900000
      tax = (($tax_bracket * 10) / 100) + 15000
    elsif $tax_bracket > 900000 && $tax_bracket <= 1200000
      tax = (($tax_bracket * 15) / 100) + 45000
    elsif $tax_bracket > 1200000 && $tax_bracket <= 1500000
      tax = (($tax_bracket * 20) / 100) + 90000
    elsif $tax_bracket > 1500000
      tax = (($tax_bracket * 30) / 100) + 150000
    else
      puts "INVALID"
    end
    tax
  end

  def payslip_params
    params.require(:payslip).permit(:slip_month, :user_id)
  end

  def set_payslips
    @payslip = Payslip.find(params[:id])
  end

end
