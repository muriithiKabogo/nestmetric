class UserMailer < ApplicationMailer

	def suscription_payment_failed(userAccount,user,customer_email, template, esubject)

		@url  = 'http://example.com/login'
	    @customer_email = customer_email
	    @template = template
	    @uid = userAccount

	    
	    mail from: user,
	    	   to: @customer_email,
	   	  subject: esubject
    end

end
.