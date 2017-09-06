class SendemailsController < ApplicationController
	before_action :authenticate_user!
	def create
		@user = current_user
		@customer_email = params[:email]
		@customer = @user.riskycustomers.find_by(email: @customer_email)
		

		if params[:risklevel] == "thirty days expiry notice"
			@esubject = "EXPIRY NOTICE"
			@template = @user.email_templates.find_by_etype("thirty days expiry notice")
			puts "I am here to kill you"
			plan = "pro"
			last4 = "4567"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
		

		elsif params[:risklevel] == "Fifteen days expiry notice"
			@esubject = "EXPIRY NOTICE"
			@template = @user.email_templates.find_by_etype("Fifteen days expiry notice")
			puts "I am here to kill you"
			plan = "pro"
			last4 = "4568"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
			
			
		elsif params[:risklevel] == "seven day expiry"
			@esubject = "EXPIRY NOTICE"
			@template = @user.email_templates.find_by_etype("seven day expiry")
			plan = "pro"
			last4 = "4569"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now

		elsif params[:risklevel] == "cancellation"
			@esubject = "cancellation"
			@template = @user.email_templates.find_by_etype("cancellation")
			plan = "pro"
			last4 = "4559"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now

		elsif params[:risklevel] == "third attempt"
			@esubject = "cancellation"
			@template = @user.email_templates.find_by_etype("third attempt")
			plan = "pro"
			last4 = "4569"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
		
		elsif params[:risklevel] == "second attempt"
			@esubject = "second attempt"
			@template = @user.email_templates.find_by_etype("second attempt")
			plan = "pro"
			last4 = "4579"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now

		else
			@esubject = "first attempt"
			@template = @user.email_templates.find_by_etype("first attempt")
			plan = "pro"
			last4 = "4589"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
		end
			
	end

end
