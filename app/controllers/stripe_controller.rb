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
  		UserMailer.suscription_payment_failed(@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
  	end
  end

  def failed_charge

  end

  def invoice_payment_failed
  	@user = User.find_by_uid(params[:account])
    customer_email = params[:data]
    attempt = params[:data][:object][:attempt_count]
    customerId = customer_email[:object][:customer]

    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    customer_email = Stripe::Customer.retrieve("cus_AgI34MFkZad9mc")
    customer_email = customer_email[:email]
    custId = "cus_AgI34MFkZad9mc"

    puts customer_email
    if @user.uid == params[:account] && attempt == 1
      @email_template = EmailTemplate.find_by_etype("first attempt")
      UserMailer.suscription_payment_failed(@user.id,custId,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now

    elsif @user.uid == params[:account] && attempt == 2

      @email_template = EmailTemplate.find_by_etype("second attempt")
      UserMailer.suscription_payment_failed(@user.id,custId,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
    elsif @user.uid == params[:account] && attempt == 3

      @email_template = EmailTemplate.find_by_etype("third attempt")
      UserMailer.suscription_payment_failed(@user.id,custId,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
    elsif @user.uid == params[:account] && attempt == 4

      @email_template = EmailTemplate.find_by_etype("cancellation")
      UserMailer.suscription_payment_failed(@user.id,custId,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
    end
  end

  def customer_source_updated
    @user = User.find_by_uid(params[:account])
    @customerID = params[:data][:object][:sources][:data][0][:customer]
    puts @customerID

    @riskycustomer = @user.riskycustomers.find_by_customerId("cus_B89RZhIIzUYsI5")
    puts @riskycustomer.expiryYear
    expiryMonth = params[:data][:object][:sources][:data][0][:exp_month]
    puts expiryMonth
    expiryYear = params[:data][:object][:sources][:data][0][:exp_year]
    puts expiryYear

    if expiryYear > @riskycustomer.expiryYear && @riskycustomer.emailsent == true
      @riskycustomer.recovered = true
      @riskycustomer.save
      puts "function works"
    end

    # if @user.riskycustomers != 0
    #     @user.riskycustomers.each do |riskycustomer|
    #        customerDetails = Stripe::Customer.retrieve(riskycustomer.customerId)
    #        expiryMonth = customerDetails["sources"]["data"][0]["exp_month"]
    #        expiryYear = customerDetails["sources"]["data"][0]["exp_year"]
    #        if expiryYear > riskycustomer.expiryYear && riskycustomer.emailsent == true
    #          riskycustomer.recovered = true
    #          riskycustomer.save
    #          puts "function works"
    #        end
    #     end
    # end
    
  end

end

