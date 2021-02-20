class RostersController < ApplicationController
  def new
    @roster = Roster.new
    @duty = Duty.find(params[:duty_id])
  end
  def create
    @duty = Duty.find(params[:duty_id])
    @roster = @duty.rosters.new(roster_params)
    if @roster.save
      redirect_to duty_path(params[:duty_id])
    else
      render :new
    end
  end
  private
  def roster_params
    params.require(:roster).permit(:date, :user_id)
  end
end
