class DutiesController < ApplicationController
  before_action :move_to_login, only: [:new, :create, :show]
  def index
    @user = User.all
    @duty = Duty.all
  end
  def new
    @duty = Duty.new
  end
  def create
    @duty = Duty.new(duty_params)
    if @duty.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @duty = Duty.find(params[:id])
    @dutys = DutyUser.where(duty_id: @duty.id)
  end

  private
  def duty_params
    params.require(:duty).permit(:name, user_ids: [])
  end
  def move_to_login
    authenticate_user!
  end
end
