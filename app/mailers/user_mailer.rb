class UserMailer < ApplicationMailer

	def suscription_payment_failed(user,customer_email, template, esubject)

		@url  = 'http://example.com/login'
	    @customer_email = customer_email
	    @template = template
	  

	    
	    mail from: user,
	    	   to: @customer_email,
	   	  subject: esubject
    end

end
