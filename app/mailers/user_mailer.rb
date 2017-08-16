class UserMailer < ApplicationMailer

	def suscription_payment_failed(last4, plan, userId, userAcount,user,customer_email, template, esubject)

	    @customer_email = customer_email
	   	#Todo a function that formats he template based on the variables userId

	    @template = template
	    @plan = plan
	    @template = @template.gsub("{{customer-email}}",@customer_email)
	    @template = @template.gsub("{{planName}}", @plan)
	  	@uid = userAcount
	  	@user = user
	  	@userId = userId
	    
	    mail from: @user,
	    	   to: @customer_email,
	   	  subject: esubject
    end

    def expiry_notice(user,customer_email,esubject)
    	@customer_email = customer_email

    	mail from: user,
	    	   to: @customer_email,
	   	  subject: esubject
    end

end
