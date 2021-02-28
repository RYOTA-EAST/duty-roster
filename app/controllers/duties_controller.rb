class DutiesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :create, :destroy]
  before_action :set_parameters, only: [:index, :new, :create, :show, :edit]
  before_action :duty_find, only: [:show, :edit, :update, :destroy]
  before_action :move_root, only: [:edit, :update, :destroy]

  def index
    @user = User.all
  end

  def new
    @dutynew = Duty.new
    render 'index'
  end

  def create
    @dutynew = Duty.new(duty_params)
    if @dutynew.save
      redirect_to duty_path(@dutynew.id)
    else
      render 'index'
    end
  end

  def show
    @dutys = DutyUser.where(duty_id: @dutyfind.id).includes(:user)
    @roster = Roster.where(duty_id: @dutyfind.id)
    @users = DutyUser.where(duty_id:@dutyfind.id).pluck(:user_id)
    render 'index'
  end

  def edit
    @dutys = DutyUser.where(duty_id: @dutyfind.id).includes(:user)
    render 'index'
  end

  def update
    if @dutyfind.update(duty_params)
      redirect_to duty_path
    else
      set_parameters
      render :index
    end
  end

  def destroy
    if @dutyfind.destroy
      redirect_to root_path
    else
      render :index
    end
  end

  def mypage
    @dutyall = Duty.find(DutyUser.where(user_id:current_user.id).pluck(:duty_id))
    @roster = Roster.where(user_id:current_user.id)
    @today = Date.current
    render :index
  end

  private

  def duty_params
    params.require(:duty).permit(:name, user_ids: [])
  end

  def set_parameters
    if user_signed_in?
      @dutyall = Duty.find(DutyUser.where(user_id:current_user.id).pluck(:duty_id))
    else
      @dutyall = Duty.all
    end
    @today = Date.current
  end

  def duty_find
    @dutyfind = Duty.find(params[:id])
  end

  def move_root
    @users = DutyUser.where(duty_id:@dutyfind.id).pluck(:user_id)
    unless @users.include?(current_user.id)
      redirect_to root_path
    end
  end
end
