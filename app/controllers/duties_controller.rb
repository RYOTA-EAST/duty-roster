class DutiesController < ApplicationController
  before_action :move_to_login, only: [:new, :create, :show]
  before_action :duty_all, only: [:index, :new, :create, :show]
  
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
    @dutyfind = Duty.find(params[:id])
    @dutys = DutyUser.where(duty_id: @dutyfind.id)
    render "index"
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

end
