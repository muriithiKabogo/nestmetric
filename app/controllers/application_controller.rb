class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protected

  def after_sign_in_path_for(resource)
  	current_user = resource
  	if current_user.uid == nil 
      if current_user.email_templates.count == 0
            fifetype = "15 day expiry notice"
             
             fifsubject = "expiry notice"

             fifbody = "<p>Hi Rosie</p>
                  <p>Your Visa card ending in 4242, which is used to process payments for 
                  the Pro Plan on Kudobuzz will expire at the end of this month (in 15 days) .</p>
                  <p>If you have a moment, please update your payment information in order to
                   continue enjoying our services.(it'll take less than a minute) using this 
                  link https://payments.stunning.co/payment_update/2037purqitmpobpklzqpdlcna/cus_testcustomerid . </p>
                  <p>Thanks for being a Kudobuzz customer!</p>
                  <p>Kennah Amoah</p>"

            firstetype = "first attempt"

            firstsubject = "Failed charge"

            firstbody = "<p>Greetings Rosie</p>
                  <p>We just tried to charge your card, but it failed for the following reason:</p>
                  <p>Card Declined.</p>
                  <p>This indicates that there's something wrong with your payment method. Most of the time this is due to <em><strong>expired credit card</strong></em> or a recently <em><strong>changed billing address.</strong></em></p>
                  <p>Please update your payment information to keep your account active
                   (it'll take less than a minute). To save you some time, here's a 
                  direct link to your payment update page </p>
                  <p>Thanks so much for choosing Kudobuzz.&nbsp; 
                  Let us know if there's anything else we can do to help you get the most out of it.</p>
                  <p>Thanks</p>
                  <p>Kenna Amoah</p>"

            secetpe = "second attempt"

            secsubject = "Failed charge"

            secbody = "<p>Greetings Rosie</p> <p>We just re-tried to charge your card for a second time, 
                  but it failed for the following reason:</p> <p>Card Declined.</p> <p>&nbsp;
                  Most of the time this is due to <em><strong>expired credit card</strong></em> or a 
                  recently <em><strong>changed billing address.</strong></em></p> <p>Please update your 
                  payment information to keep your account active (it'll take less than a minute).
                   To save you some time, here's a direct link to your payment update page
                   http://example.com/login</a></p> <p>Thanks so much for choosing Kudobuzz.&nbsp; 
                   Let us know if there's anything else we can do to help you get the most out of it.</p>
                    <p>Thanks</p> <p>Kenna Amoah</p>"

            thietye = "third attempt"

            thisubject = "Failed charge"

            thibody = "<p>Greetings Rosie</p> <p>We just re-tried to charge your card for a 
                  third time, but it failed for the following reason:</p> <p>Card Declined.</p> 
                  <p>&nbsp;Most of the time this is due to <em><strong>expired credit card</strong></em> or
                   a recently <em><strong>changed billing address.</strong></em></p> 
                   <p>Please update your payment information to keep your account active
                    (it'll take less than a minute). To save you some time, h
                    ere's a direct link to your payment update page </p> <p>
                    Thanks so much for choosing Kudobuzz.&nbsp; Let us know if there's anything
                     else we can do to help you get the most out of it.</p> <p>Thanks</p> <p>Kenna Amoah</p>"


            cancetype = "cancellation"

            cancsubject = "cancellation"

            cancbody = "<p>Greetings rosie</p> <p>We&rsquo;ve attempted to bill your credit card
                   4 times, but have been unsuccessful. The following is the last response we
                    received when trying to bill your account:</p> <p>Credit card Declined.
                    </p> <p>Please update your payment information to keep your account active 
                    (it'll take less than a minute). To save you some time, here's a direct
                     link to your payment update page .In the meantime, we have disabled your account.
                     </p> <p>Let us know if you need help on how to go about updating your billing information.
                     </p> <p>Thanks,</p> <p>Kennah Amoah</p> "


            thirtytype = "thirty day expiry notice "

            thirtysubject = "Expiry Notice"

            thirtybody = ">Hi Rosie</p> <p>Your Visa card ending in 4242, which is
                   used to process payments for the Pro Plan on Kudobuzz will expire at the
                   end of this month(in 30 days).</p> <p>If you have a moment,
                   please update your payment information (it'll take less than a minute) 
                   using this link </p>
                   <p>Thanks for being a Kudobuzzcustomer!</p> <p>Kennah Amoah</p> <p>&nbsp;</p> "




            sevetype = "seven day expiry"

            sevesubject = "Expiry Notice"


            sevbody = "Hi Rosie</p> <p>Your Visa card ending in 4242, 
                  which is used to process payments for the Pro Plan on Kudobuzz
                  will expire at the end of this month (in 7 days) .</p> 
                  <p>If you have a moment, please update your payment information
                  in order to continue enjoying our services.(it'll take less than a minute)
                  using this link 
                  .</p>
                  <p>Thanks for being a Kudobuzz customer!</p> <p>Kennah Amoah</p> 
                  "
          current_user.email_templates.create(etype: fifetype,subject: fifsubject,body: fifbody)
          current_user.email_templates.create(etype: firstetype,subject: firstsubject,body: firstbody)
          current_user.email_templates.create(etype: secetpe,subject: secsubject,body: secbody)
          current_user.email_templates.create(etype: thietye,subject: thisubject,body: thibody)
          current_user.email_templates.create(etype: cancetype,subject: cancsubject,body: cancbody)
          current_user.email_templates.create(etype: thirtytype,subject: thirtysubject,body: thirtybody)
          current_user.email_templates.create(etype: sevetype,subject: sevetype,body: sevbody)
      end
  		user_path(current_user.id)
  	else
	   users_path
	end
	
  end

 private
  #failed charges
  def get_charges_not_paid(string)
    @user.stripe_charges_not_paid["#{string}"]
  end

  def failed_charges
    v = []
    get_charges_not_paid("data").each do |charge|
      if charge.status == "failed" 
        v.push(charge)
      end
    end
    v.length
  end

  def failed_charges_thirty_days_ago
    v = []
    get_charges_not_paid("data").each do |charge|
      if charge.status == "failed" && Time.at(charge["created"])<= thirty_days_ago
        v.push(charge)
      end
    end
    v.length
  end

  def failed_charges_last_30_days
    v = []
    get_charges_not_paid("data").each do |charge|
      if charge.status == "failed"
        v.push(charge)
      end
    end
    v
  end

  def failed_charges_ninety_days_ago
    v = []
    get_charges_not_paid("data").each do |charge|
      if charge.status == "failed" && Time.at(charge["created"])<= ninety_days_ago
        v.push(charge)
      end
    end
    v.length
  end

  def failed_charges_one_eighty_days_ago
    v = []
    get_charges_not_paid("data").each do |charge|
      if charge.status == "failed" && Time.at(charge["created"])<= one_eighty_days_ago
        v.push(charge)
      end
    end
    v.length
  end


  def failed_charges_three_sixty_days_ago
    v = []
    get_charges_not_paid("data").each do |charge|
      if charge.status == "failed" && Time.at(charge["created"])<= three_sixty_days_ago
        v.push(charge)
      end
    end
    v.length
  end

  #cancellations#
  #returns a list of 100 cancellations
  def get_all_cancellations_list
    @user.stripe_cancellation
  end

#returns all the cancellations with from the beginning
  def get_all_cancellations
    v = []
    get_all_cancellations_list.auto_paging_each do |cancellation|
      v.push(cancellation)
    end
    v
  end
#total cancellations for the last 30days
  def cancellation_for_last_30_days
    v=[]
    get_all_cancellations.each do |cancellation|
      
       if Time.at(cancellation["canceled_at"]) <
          Time.now && Time.at(cancellation["canceled_at"]) >= thirty_days_ago
        v.push(cancellation)
       end  
    end
    v.length
  end
#people who have cancelled
  def all_cancellation_for_last_30_days
    v=[]
    get_all_cancellations.each do |cancellation|
      
       if Time.at(cancellation["canceled_at"]) <
          Time.now && Time.at(cancellation["canceled_at"]) >= thirty_days_ago
        v.push(cancellation)
       end  
    end
    v
  end

#cancellations as at a 30 days ago
  def cancellation_thirty_days_ago
      v=[]
      get_all_cancellations.each do |cancellation|
        
         if Time.at(cancellation["canceled_at"]) <= thirty_days_ago
          v.push(cancellation)
         end  
      end
      v.length
  end

  def cancellation_ninety_days_ago
      v=[]
      get_all_cancellations.each do |cancellation|
        
         if Time.at(cancellation["canceled_at"]) <= ninety_days_ago
          v.push(cancellation)
         end  
      end
      v.length
  end

  def cancellation_one_eighty_days_ago
      v=[]
      get_all_cancellations.each do |cancellation|
        
         if Time.at(cancellation["canceled_at"]) <= one_eighty_days_ago
          v.push(cancellation)
         end  
      end
      v.length
  end

   def cancellation_three_sixty_days_ago
      v=[]
      get_all_cancellations.each do |cancellation|
        
         if Time.at(cancellation["canceled_at"]) <= three_sixty_days_ago
          v.push(cancellation)
         end  
      end
      v.length
  end


#converts and calculates the date 30 days ago
  def thirty_days_ago
    date_in_sec = Time.now - Time.at(2629743)
    return Time.at(date_in_sec)
  end
#converts and calculates the date 90 days ago
  def ninety_days_ago
    date_in_sec = Time.now - Time.at(7789229)
    return Time.at(date_in_sec)
  end
#converts and calculates the date 180 days ago
  def one_eighty_days_ago
    date_in_sec = Time.now - Time.at(15578458)
    return Time.at(date_in_sec)
  end
#converts and calculates the date 360 days ago
  def three_sixty_days_ago
    date_in_sec = Time.now - Time.at(31156916)
    return Time.at(date_in_sec)
  end




end
