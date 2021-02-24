class RostersController < ApplicationController
  before_action :set_duty, only: [:new, :create, :destroy]
  before_action :set_parameter, only: [:new, :create]

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
    # @rosternew = Roster.new
    # binding.pry
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

  def set_duty
    @dutyall = Duty.all
    @dutyfind = Duty.find(params[:duty_id])
  end
  def set_parameter
    @dutyfind = Duty.find(params[:duty_id])
    @roster = Roster.where(duty_id: @dutyfind.id)
    @dutys = DutyUser.where(duty_id: @dutyfind.id).includes(:user)
    @today = Date.current
  end
end
