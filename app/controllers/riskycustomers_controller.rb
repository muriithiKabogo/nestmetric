class RiskycustomersController < ApplicationController
  
  def index
  	@user = current_user
  	@riskycustomers = @user.riskycustomers
  end

  def new
  	@user = current_user
  end

  def create
  end

end
