class CustomerHealthsController < ApplicationController
before_action :authenticate_user!

	def index
		@user = current_user
		@riskycustomers = @user.riskycustomers
	end

end
