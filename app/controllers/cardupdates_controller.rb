class CardupdatesController < ApplicationController
	
	def edit
		@user = User.find_by_uid(params[:uid])
		sign_in(@user)
		redirect_to new_riskycustomer_path
	end
end
