class SendemailsController < ApplicationController
	before_action :authenticate_user!
	def create
		@user = current_user
		@customer_email = "duncan.muriithi@meltwater.org" 

		if params[:risklevel] == "risky"
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user.email,@customer_email,@esubject).deliver_now

		elsif params[:risklevel] == "riskier"
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user.email,@customer_email,@esubject).deliver_now
		else
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user.email,@customer_email,@esubject).deliver_now
		end
			
	end

end
