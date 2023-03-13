# frozen_string_literal: true

class LeaveBalancesController < ApplicationController
  load_and_authorize_resource

  before_action :set_leaves, only: %i[show update destroy admin_update]

  def index
    @leave = LeaveBalance.all.as_json(except: %i[created_at updated_at], include: ['user' => { only: :full_name }])
    if @leave
      render json: @leave,
             status: :ok
    else
      render json: { message: 'FAILED!' },
             status: :unprocessable_entity
    end
  end

  def create
    @leave = LeaveBalance.new(leave_balance_params)
    if @leave.save!
      render json: { message: 'Successfully added data' },
             status: :ok
    else
      render json: { message: 'FAILED!' }
    end
  end

  def show
    if @leave
      render json: @leave,
             status: :ok,
             except: %i[created_at updated_at],
             include: ['user' => { only: :full_name }]
    else
      render json: { message: 'FAILED!' },
             status: :unprocessable_entity
    end
  end

  def update
    case @leave.leave_status
    when 'Approved'
      render json: { message: 'Cannot be changed by user after approval.' }
    when 'Applied'
      if @leave.update(leave_update_params)
        render json: { message: 'Successfully updated data!' },
               status: :ok
      else
        render json: { message: 'FAILED!' }
      end
    else
      render json: { message: 'Has been rejected' }
    end
  end

  def destroy
    if @leave.destroy
      render json: { message: 'Successfully deleted data!' },
             status: :ok
    else
      render json: { message: 'FAILED!' }
    end
  end

  def admin_update
    if @leave.update(leave_admin_params)
      render json: { message: 'Successfully updated data!' },
             status: :ok
    else
      render json: { message: 'FAILED!' }
    end
  end

  def find_leaves
    @user = User.find(current_user.id)
    @leave = LeaveBalance.all.where(user_id: @user.id).as_json(except: %i[created_at updated_at],
                                                               include: ['user' => { only: :full_name }])
    render json: @leave,
           status: :ok
  end

  private

  def leave_balance_params
    params.require(:leave_balance).permit(:start_date, :end_date, :leave_type, :leave_details, :user_id)
  end

  def leave_admin_params
    params.require(:leave_balance).permit(:start_date, :end_date, :leave_type, :leave_details, :leave_status)
  end

  def leave_update_params
    params.require(:leave_balance).permit(:start_date, :end_date, :leave_type, :leave_details)
  end

  def set_leaves
    @leave = LeaveBalance.find(params[:id])
  end
end
