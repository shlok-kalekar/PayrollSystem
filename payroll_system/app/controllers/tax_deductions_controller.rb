class TaxDeductionsController < ApplicationController

  load_and_authorize_resource

  before_action :set_deduction, only: %i[show update destroy]

  def index
    @tax_deduction = TaxDeduction.all.as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    if @user
      render json: @tax_deduction,
              status: :ok
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end
  end

  def create
    if @tax_deduction.save!
      render json: {message: "Successfully added data"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def show
    if @tax_deduction
      render json: @tax_deduction,
              status: :ok,
              except: %i[created_at updated_at],
              include: ["user" => {:only => :full_name}]
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end

  end

  def update
    if @tax_deduction.update(update_params)
      render json: {message: "Successfully updated data!"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def destroy
    if @tax_deduction.destroy
      render json: {message: "Successfully deleted data!"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def find_tax_deductions
    @user = User.find(current_user.id)
    @tax_deduction = TaxDeduction.all.where(user_id: @user.id).as_json(except: %i[created_at updated_at], include: ["user" => {:only => :full_name}])
    render json: @tax_deduction,
            status: :ok
  end

  private
  def tax_deduction_params
    params.require(:tax_deduction).permit(:deduct_type, :deduct_amount, :financial_year, :user_id)
  end

  def update_params
    params.require(:tax_deduction).permit(:deduct_type, :deduct_amount, :financial_year)
  end

  def set_deduction
    @tax_deduction = TaxDeduction.find(params[:id])
  end

end