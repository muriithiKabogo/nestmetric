class StripeController < ApplicationController
 protect_from_forgery except: :webhook

 
  def webhook
  	@user = User.find_by_uid(params[:account])
  	customer_email = params[:data]
  	customer_email = "dmuriithi.k@gmail.com"#customer_email[:object][:receipt_email]
  	puts customer_email
  	@email_template = EmailTemplate.find_by_etype("first attempt")
  	puts @email_template.body
  	
  	if @user.uid == params[:account] 
  		UserMailer.suscription_payment_failed(@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
  	end
  end

  def failed_charge

  end

  def invoice_payment_failed
  	@user = User.find_by_uid(params[:account])
    customer_email = params[:data]
    attempt = params[:data][:object][:attempt_count]
    customer_email = customer_email[:object][:customer]

    # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    # customerDetails = Stripe::Customer.retrieve(customerId)

    puts customer_email
    if @user.uid == params[:account] && attempt == 1
      @email_template = EmailTemplate.find_by_etype("first attempt")
      UserMailer.suscription_payment_failed(@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now

    elsif @user.uid == params[:account] && attempt == 2

      @email_template = EmailTemplate.find_by_etype("second attempt")
      UserMailer.suscription_payment_failed(@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
    elsif @user.uid == params[:account] && attempt == 3

      @email_template = EmailTemplate.find_by_etype("third attempt")
      UserMailer.suscription_payment_failed(@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
    elsif @user.uid == params[:account] && attempt == 4

      @email_template = EmailTemplate.find_by_etype("cancellation")
      UserMailer.suscription_payment_failed(@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
    end
  end

end

