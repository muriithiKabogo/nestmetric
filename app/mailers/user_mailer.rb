class UserMailer < ApplicationMailer

	def suscription_payment_failed
	@url  = 'http://example.com/login'
    @email = "dmuriithi.k@gmail.com"
    mail to: @email, subject: "Failed Payment"
  end
end
