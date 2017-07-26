class UserMailer < ApplicationMailer

	def suscription_payment_failed(userId,custId, userAcount,user,customer_email, template, esubject)

		@url  = 'http://example.com/login'
	    @customer_email = customer_email
	    @template = template
	  	@uid = userAcount
	  	@custId = custId
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
