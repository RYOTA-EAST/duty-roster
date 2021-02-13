class DutiesController < ApplicationController
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

  private
  def duty_params
    params.require(:duty).permit(:name, user_ids: [])
  end
end
