class CardupdatesController < ApplicationController
	
	def edit
		@user = User.find_by(uid: params[:uid])
		sign_in(:user, @user)
		redirect_to new_riskycustomer_path
	end
end
