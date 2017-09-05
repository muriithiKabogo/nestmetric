class SendEmailWorker
  include Sidekiq::Worker

  def perform(*args)
    users = User.all
    x= 0

    users.each do |user|
    	@template = user.email_templates.find_by_etype("thirty days expiry notice")

    	if user.riskycustomers.exists?
    		user.riskycustomers.each do |customer|
    			x = x+1
	    		@customer_email = customer.email
	    		@esubject = "EXPIRY NOTICE"
          last4 = customer.last4
          plan = customer.plan
        puts last4
        puts plan
				puts "#{x}. I am here to kill you"
				UserMailer.expiry_notice(plan, last4, @template, user.email, @customer_email, @esubject).deliver_now
				puts "emailsent"
				customer.emailsent = true
				customer.save
			end
    	end
    end
  end
end
