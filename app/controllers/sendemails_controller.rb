class SendemailsController < ApplicationController
	before_action :authenticate_user!
	def create
		@user = current_user
		@customer_email = "duncan.muriithi@meltwater.org"#params[:email] 

		if params[:risklevel] == "risky"
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user,@customer_email,@esubject)

		elsif params[:risklevel] == "riskier"
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user,@customer_email,@esubject)
		else
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user,@customer_email,@esubject)
		end
			
	end

end
