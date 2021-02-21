class RostersController < ApplicationController
  before_action :set_duty, only: [:new, :create, :destroy]

  def new
    @roster = Roster.new
  end

  def create
    @roster = @duty.rosters.new(roster_params)
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
    @duty = Duty.find(params[:duty_id])
  end
end
