class UsersController < ApplicationController

  load_and_authorize_resource

  before_action :set_user, only: %i[show update destroy]

  def index
    @user = User.all.as_json(except: %i[created_at updated_at jti role_id], include: ["role" => {:only => :role_type}])
    if @user
      render json: @user,
              status: :ok
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {message: "Successfully added data"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def show
    if @user
      render json: @user,
              status: :ok,
              except: %i[created_at updated_at jti],
              include: ["role" => {:only => :role_type}]
    else
      render json: { message: 'FAILED!'},
              status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: {message: "Successfully updated data!"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end
  end

  def destroy
    if @user.destroy
      render json: {message: "Successfully deleted data!"},
      status: :ok
    else
      render json: {message: "FAILED!"}
    end

  end

  def find_user_info
    @user = User.find(current_user.id)
    @user = User.all.where(id: @user.id).as_json(except: %i[created_at updated_at jwt role_id], include: ["role" => {:only => :role_type}])
    render json: @user,
            status: :ok
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :gender_type, :phone_no, :designation_type,
      :city_name, :join_date, :tot_paid_leaves, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end


end