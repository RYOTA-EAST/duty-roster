class DutiesController < ApplicationController
  before_action :move_to_login, only: [:new, :create, :show]
  before_action :set_parameter, only: [:index, :new, :create, :show, :edit]
  before_action :duty_find, only: [:show, :edit, :update, :destroy]
  
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

  def edit
    @dutys = DutyUser.where(duty_id: @dutyfind.id)
    render "index"
  end

  def update
    if @dutyfind.update(duty_params)
      redirect_to duty_path
    else
      render :edit 
    end
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

  def set_parameter
    @dutyall = Duty.all
    @today = Date.current
  end

  def duty_find
    @dutyfind = Duty.find(params[:id])
  end

end
