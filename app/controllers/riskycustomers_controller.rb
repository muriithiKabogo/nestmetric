class RiskycustomersController < ApplicationController
  before_action :authenticate_user! except: :new
  def index
  	@user = current_user
  	@riskycustomers = @user.riskycustomers
  end

  def new
  	@user = @user = User.find_by_uid(params[:uid])
  end


end
