class SendemailsController < ApplicationController
	before_action :authenticate_user!
	def create
		@user = current_user
		@customer_email = params[:email]
		@customer = @user.riskycustomers.find_by(email: @customer_email)
		

		if params[:risklevel] == "risky"
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user.email,@customer_email,@esubject).deliver_now
			@customer.emailsent = true
			@customer.save

		elsif params[:risklevel] == "riskier"
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user.email,@customer_email,@esubject).deliver_now
			@customer.emailsent = true
			@customer.save
			
		else
			@esubject = "EXPIRY NOTICE"
			puts "I am here to kill you"
			UserMailer.expiry_notice(@user.email,@customer_email,@esubject).deliver_now
			@customer.emailsent = true
			@customer.save
		end
			
	end

end
