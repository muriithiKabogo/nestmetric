class UserMailer < ApplicationMailer

	def suscription_payment_failed(reason,last4, plan, userId, userAcount,user,customer_email, template, esubject)

	    @customer_email = customer_email
	   	#Todo a function that formats he template based on the variables userId

	    @template = template
	    @plan = plan
	    @reason = reason
	    @last4 = last4

	    @template = @template.gsub("{{customer-email}}",@customer_email)
	    @template = @template.gsub("{{planName}}", @plan)
	    @template = @template.gsub("{{failureMessage}}", @reason)
	    @template = @template.gsub("{{last4numbers}}", @last4)
 
	  	@uid = userAcount
	  	@user = user
	  	@userId = userId
	    
	    mail from: @user,
	    	   to: @customer_email,
	   	  subject: esubject
    end

    def expiry_notice(plan,last4,template,user,customer_email,esubject)
    	@customer_email = "dmuriithi.k@gmail.com"#customer_email
    	@template = template.body
 		@last4 = last4
 		@plan = plan

 		@template = @template.gsub("{{planName}}", @plan)
		@template = @template.gsub("{{last4numbers}}", @last4)
		@template = @template.gsub("{{customer-email}}",@customer_email)
		
      	mail from: user,
	    	   to: @customer_email,
	   	  subject: esubject
    end

end
