class StripeController < ApplicationController
 protect_from_forgery except: :webhook

 
  def webhook
  	@user = User.find_by_uid(params[:account])
  	customer_email = params[:data]
  	customer_email = customer_email[:object][:receipt_email]
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
    customer_data = params[:data]
    attempt = params[:data][:object][:attempt_count]
    customerId = customer_data[:object][:customer]
    customerPlan = customer_data[:object][:lines][:data][0][:plan][:id]
    chargeID = customer_data[:object][:charge]
    if Rails.env.production?
         Stripe.api_key = ENV['@user.access_code'] 
    else
         Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
    customer_data = Stripe::Customer.retrieve(customerId) #"cus_AgI34MFkZad9mc"
    chargeData = Stripe::Charge.retrieve(chargeID) # "ch_1ArPKKEv2HD4YYepax5YYSBS"
    customer_email = customer_data[:email]
    customer_last4 = customer_data[:sources][:data][0][:last4]
    reason  = chargeData[:failure_message]
    amount = chargeData[:amount]
    failed_at = Time.at(chargeData[:created])
    customer_id = chargeData[:customer] 

    puts customer_email
    puts customerPlan
    puts reason
    puts amount
    puts customer_id
    puts failed_at
    puts attempt

    if @user.uid == params[:account] && attempt == 1
      @email_template = EmailTemplate.find_by_etype("first attempt")
      if @email_template.active == false
        UserMailer.suscription_payment_failed(reason,customer_last4,customerPlan,@user.id,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
        @user.sents.create(etype: @email_template.etype,content: @email_template.body, to: customer_email,from: @user.email)
        @user.failed_charges.create(email: customer_email,plan:customerPlan,amount:amount, failed_at: failed_at ,customer_id: customer_id ,reason: reason, attempt: attempt)
      end
      
    elsif @user.uid == params[:account] && attempt == 2

      @email_template = EmailTemplate.find_by_etype("second attempt")

      if @email_template.active == true
        UserMailer.suscription_payment_failed(reason,customer_last4,customerPlan,@user.id,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
        @user.sents.create(etype: @email_template.etype,content: @email_template.body, to: customer_email,from: @user.email)
        @user.failed_charges.create(email: customer_email,plan:customerPlan,amount:amount, failed_at: failed_at ,customer_id: customer_id ,reason: reason, attempt: attempt)
      end
    elsif @user.uid == params[:account] && attempt == 3

      @email_template = EmailTemplate.find_by_etype("third attempt")
      if @email_template.active == true
        UserMailer.suscription_payment_failed(reason,customer_last4,customerPlan,@user.id,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
        @user.sents.create(etype: @email_template.etype,content: @email_template.body, to: customer_email,from: @user.email)
        @user.failed_charges.create(email: customer_email,plan:customerPlan,amount:amount, failed_at: failed_at ,customer_id: customer_id ,reason: reason, attempt: attempt)
      end

    elsif @user.uid == params[:account] && attempt == 4

      @email_template = EmailTemplate.find_by_etype("cancellation")
      if @email_template.active == true
        UserMailer.suscription_payment_failed(reason,customer_last4,customerPlan,@user.id,@user.uid,@user.email,customer_email,@email_template.body,@email_template.subject).deliver_now
        @user.sents.create(etype: @email_template.etype,content: @email_template.body, to: customer_email,from: @user.email)
        @user.failed_charges.create(email: customer_email,plan:customerPlan,amount:amount, failed_at: failed_at ,customer_id: customer_id ,reason: reason, attempt: attempt)
      end

    end
  end

  def customer_source_updated
    @user = User.find_by_uid(params[:account])
    @customerID = params[:data][:object][:sources][:data][0][:customer]
    puts @customerID

    if @user.riskycustomers.where(customerId: @customerID).exists?
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

