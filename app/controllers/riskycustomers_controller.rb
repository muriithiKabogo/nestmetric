class RiskycustomersController < ApplicationController
  before_action :authenticate_user!
  def index
  	@user = current_user
  	@riskycustomers = @user.riskycustomers
  end

  def new
  	@user = current_user
  end
end
