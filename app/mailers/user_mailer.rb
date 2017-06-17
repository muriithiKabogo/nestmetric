class UserMailer < ApplicationMailer
 
default from: user.email

def suscription_payment_failed
    @email = "dmuriithi.k@gmail.com"
    mail to: @email, subject: "Failed Payment"
 end

 def user
 	@user = current_user
 end
end
