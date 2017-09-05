class SendemailsController < ApplicationController
	before_action :authenticate_user!
	def create
		@user = current_user
		@customer_email = params[:email]
		@customer = @user.riskycustomers.find_by(email: @customer_email)
		

		if params[:risklevel] == "risky"
			@esubject = "EXPIRY NOTICE"
			@template = @user.email_templates.find_by_etype("thirty days expiry notice")
			puts "I am here to kill you"
			plan = @customer.plan
			last4 = @customer.last4
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
			@customer.emailsent = true
			@customer.save

		elsif params[:risklevel] == "riskier"
			@esubject = "EXPIRY NOTICE"
			@template = @user.email_templates.find_by_etype("Fifteen days expiry notice")
			puts "I am here to kill you"
			plan = @customer.plan
			last4 = @customer.last4
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
			@customer.emailsent = true
			@customer.save
			
		else
			@esubject = "EXPIRY NOTICE"
			@template = @user.email_templates.find_by_etype("seven day expiry")
			plan = @customer.plan
			last4 = @customer.last4
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
			@customer.emailsent = true
			@customer.save
		end
			
	end

end
