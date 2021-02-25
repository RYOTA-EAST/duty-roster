class RostersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_parameters, only: [:new, :create, :destroy]
  before_action :move_root, only: [:new, :create, :destroy]

  def new
    @rosternew = Roster.new
    render template: 'duties/index'
  end

  def create
    @rosternew = @dutyfind.rosters.new(roster_params)
    if @rosternew.save
      redirect_to duty_path(params[:duty_id])
    else
    @roster = Roster.where(duty_id: @dutyfind.id)
    render template: 'duties/index'
    end
  end

  def destroy
    @roster = Roster.find(params[:id])
    if @roster.destroy
      redirect_to duty_path(params[:duty_id])
    else
      render :show
    end
  end

  private

  def roster_params
    params.require(:roster).permit(:date, :user_id)
  end

  def set_parameters
    @dutyall = Duty.all
    @dutyfind = Duty.find(params[:duty_id])
    @dutys = DutyUser.where(duty_id: @dutyfind.id).includes(:user)
    @roster = Roster.where(duty_id: @dutyfind.id)
    @today = Date.current
  end

  def move_root
    @users = DutyUser.where(duty_id:@dutyfind.id).pluck(:user_id)
    unless @users.include?(current_user.id)
      redirect_to root_path
    end
  end
end
