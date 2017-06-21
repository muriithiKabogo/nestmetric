class StripeController < ApplicationController
 protect_from_forgery except: :webhook

 
  def webhook
  	 	UserMailer.suscription_payment_failed.deliver_now
  end

  def failed_charge

  end

  def invoice_payment_failed
  	
  end

end
