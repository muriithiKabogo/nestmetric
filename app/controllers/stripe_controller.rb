class StripeController < ApplicationController
 protect_from_forgery except: :webhook

 
  def webhook
  	 	UserMailer.suscription_payment_failed.deliver_now
  end

end
