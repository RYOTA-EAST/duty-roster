class RostersController < ApplicationController
  before_action :set_duty, only: [:new, :create, :destroy]

  def new
    @roster = Roster.where(duty_id: @dutyfind.id)
    @rosternew = Roster.new
    @dutys = DutyUser.where(duty_id: @dutyfind.id).includes(:user)
    @today = Date.current
    render template: 'duties/index'
  end

  def create
    @roster = @dutyfind.rosters.new(roster_params)
    if @roster.save
      redirect_to duty_path(params[:duty_id]), layout: false
    else
      render :new
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

  def set_duty
    @dutyall = Duty.all
    @dutyfind = Duty.find(params[:duty_id])
  end
end
