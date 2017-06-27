class StripeController < ApplicationController
 protect_from_forgery except: :webhook

 
  def webhook
  	@user = User.find_by_uid(params[:account])
  	customer_email = params[:data]
  	customer_email = "jerry@meltwater.org "#customer_email[:object][:receipt_email]
  	puts customer_email
  	@email_template = EmailTemplate.find_by_etype("first attempt")
  	puts @email_template.body
  	
  	if @user.uid == params[:account] 
  		UserMailer.suscription_payment_failed(@user.email,customer_email,@email_template.body).deliver_now
  	end
  end

  def failed_charge

  end

  def invoice_payment_failed
  	
  end

end
