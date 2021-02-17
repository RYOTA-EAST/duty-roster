class DutiesController < ApplicationController
  before_action :move_to_login, only: [:new, :create, :show]
  before_action :duty_all, only: [:index, :new, :create, :show]
  before_action :duty_find, only: [:show, :destroy]
  
  def index
    @user = User.all
  end

  def new
    @dutynew = Duty.new
    render "index"
  end

  def create
    @dutynew = Duty.new(duty_params)
    if @dutynew.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @dutys = DutyUser.where(duty_id: @dutyfind.id)
    render "index"
  end

  def destroy
    if @dutyfind.destroy
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def duty_params
    params.require(:duty).permit(:name, user_ids: [])
  end

  def move_to_login
    authenticate_user!
  end

  def duty_all
    @dutyall = Duty.all
  end

  def duty_find
    @dutyfind = Duty.find(params[:id])
  end

end
