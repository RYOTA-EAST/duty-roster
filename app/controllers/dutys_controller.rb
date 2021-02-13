class DutysController < ApplicationController
  def index
    @user = User.all
  end
end
