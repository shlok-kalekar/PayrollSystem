# frozen_string_literal: true

class SalariesController < ApplicationController
  load_and_authorize_resource

  before_action :set_salary, only: %i[show update destroy]

  def index
    # @salary = Salary.accessible_by(current_ability)
    @salary = Salary.all.as_json(except: %i[created_at updated_at], include: ['user' => { only: :full_name }])
    if @salary
      render json: @salary,
             status: :ok
    else
      render json: { message: 'FAILED!' },
             status: :unprocessable_entity
    end
  end

  def create
    @salary = Salary.new(salary_params)
    if @salary.save
      render json: { message: 'Successfully added data' },
             status: :ok
    else
      render json: { message: 'FAILED!' }
    end
  end

  def show
    if @salary
      render json: @salary,
             status: :ok,
             except: %i[created_at updated_at],
             include: ['user' => { only: :full_name }]
    else
      render json: { message: 'FAILED!' },
             status: :unprocessable_entity
    end
  end

  def update
    if @salary.update(update_params)
      render json: { message: 'Successfully updated data!' },
             status: :ok
    else
      render json: { message: 'FAILED!' }
    end
  end

  def destroy
    if @salary.destroy
      render json: { message: 'Successfully deleted data!' },
             status: :ok
    else
      render json: { message: 'FAILED!' }
    end
  end

  def find_emp_salary
    @user = User.find(current_user.id)
    @salary = Salary.all.where(user_id: @user.id).as_json(except: %i[created_at updated_at],
                                                          include: ['user' => { only: :full_name }])
    render json: @salary,
           status: :ok
  end

  private

  def salary_params
    params.require(:salary).permit(:monthly_salary, :salary_month, :user_id)
  end

  def update_params
    params.require(:salary).permit(:monthly_salary, :salary_month)
  end

  def set_salary
    @salary = Salary.find(params[:id])
  end
end
