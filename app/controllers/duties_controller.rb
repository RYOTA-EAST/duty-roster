class DutiesController < ApplicationController
  def index
    @user = User.all
  end
  def new
    @duty = Duty.new
  end
end
