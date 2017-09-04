class ThirdEmailWorker
  include Sidekiq::Worker

  def perform(*args)
    users = User.all
    x= 0
    users.each do |user|
    	if user.riskycustomers.exists?
    		user.riskycustomers.each do |customer|
    			x = x+1
	    		@customer_email = customer.email
	    		@esubject = "EXPIRY NOTICE"
				puts "#{x}. I am here to kill you"
				UserMailer.expiry_notice(user.email,@customer_email,@esubject).deliver_now
				puts "emailsent"
				customer.emailsent = true
				customer.save
			end
    	end
    end
  end
  
end
