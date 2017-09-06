class SendemailsController < ApplicationController
	before_action :authenticate_user!
	def create
		@user = current_user
		@customer_email = @user.email
		@customer = @user.riskycustomers.find_by(email: @customer_email)
		

		if params[:risklevel] == "thirty days expiry notice"
			@template = @user.email_templates.find_by_etype("thirty days expiry notice")
			@esubject = @template.subject
			puts "I am here to kill you"
			plan = "pro"
			last4 = "4567"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
		

		elsif params[:risklevel] == "Fifteen days expiry notice"
			@template = @user.email_templates.find_by_etype("Fifteen days expiry notice")
			@esubject = @template.subject
			puts "I am here to kill you"
			plan = "pro"
			last4 = "4568"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
			
			
		elsif params[:risklevel] == "seven day expiry"
			
			@template = @user.email_templates.find_by_etype("seven day expiry")
			@esubject = @template.subject
			plan = "pro"
			last4 = "4569"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now

		elsif params[:risklevel] == "cancellation"
			
			@template = @user.email_templates.find_by_etype("cancellation")
			@esubject = @template.subject
			plan = "pro"
			last4 = "4559"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now

		elsif params[:risklevel] == "third attempt"
			@template = @user.email_templates.find_by_etype("third attempt")
			@esubject = @template.subject
			plan = "pro"
			last4 = "4569"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
		
		elsif params[:risklevel] == "second attempt"
			@template = @user.email_templates.find_by_etype("second attempt")
			@esubject = @template.subject
			plan = "pro"
			last4 = "4579"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now

		else
			@template = @user.email_templates.find_by_etype("first attempt")
			@esubject = @template.subject
			plan = "pro"
			last4 = "4589"
			puts "I am here to kill you"
			UserMailer.expiry_notice(plan, last4, @template,@user.email,@customer_email,@esubject).deliver_now
		end
			
	end

end
