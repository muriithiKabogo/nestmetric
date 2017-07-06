class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :email_templates

    def send_failed_payment_email
      UserMailer.suscription_payment_failed(self).deliver_now
    end

  def stripe_subscriptions
    
    if Rails.env.production?
      # Stripe.api_key = ENV['STRIPE_SECRET_KEY_PRO']
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    else
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
    begin
      Stripe::Subscription.list({limit: 100})
    rescue Exception => e
      print e
    end
    
  end

  def getCustomersIds(user)
  	customers = user.stripe_subscriptions["data"]
  		customerIds = []
  	customers.each do|customer|
  		customerIds.push(customer["customer"])
  	end
  	customerIds
  end

  def notDelinquentButRisky(user)
    nonDelinquentButRiskyCustomers = []
    getCustomersIds(user).each do |customerId|  
      customerDetails = Stripe::Customer.retrieve(customerId)
      delinquent =  customerDetails["delinquent"]

      if delinquent == false
        nonDelinquentButRiskyCustomers = nonDelinquentButRiskyCustomers.push(customerId)
      end
    end
    puts nonDelinquentButRiskyCustomers.length
  end


  def retrieveCustomer(user)
    risky = []
    riskier = []
    riskiest = []

    getCustomersIds(user).each do |customerId|
        customerDetails = Stripe::Customer.retrieve(customerId)
        expiryMonth = customerDetails["sources"]["data"][0]["exp_month"]
        expiryYear = customerDetails["sources"]["data"][0]["exp_year"]
        
        if expiryMonth == Date.today.month && expiryYear == Date.today.year
          if  Date.today.day  >= 1 && Date.today.day < 15
              risky = risky.push(customerId)
          elsif Date.today.day >= 15 && Date.today.day < 22
              riskier = riskier.push(customerId)  
          else
              riskiest = riskiest.push(customerId)
          end
        end     
    end
    puts risky.length
    puts riskier.length
    puts riskiest.length
  end


   def retrieveRiskyCustomer(user)
    risky = []
    getCustomersIds(user).each do |customerId|
        customerDetails = Stripe::Customer.retrieve(customerId)
        expiryMonth = customerDetails["sources"]["data"][0]["exp_month"]
        expiryYear = customerDetails["sources"]["data"][0]["exp_year"]
        
        if expiryMonth == Date.today.month && expiryYear == Date.today.year
          if  Date.today.day  >= 1 && Date.today.day < 15
              risky = risky.push(customerId)
          end
        end     
    end
    puts risky.length
  end

  def retrieveRiskierCustomer(user)
    riskier = []
    getCustomersIds(user).each do |customerId|
        customerDetails = Stripe::Customer.retrieve(customerId)
        expiryMonth = customerDetails["sources"]["data"][0]["exp_month"]
        expiryYear = customerDetails["sources"]["data"][0]["exp_year"]
        
        if expiryMonth == Date.today.month && expiryYear == Date.today.year
          if Date.today.day >= 15 && Date.today.day < 22
              riskier = riskier.push(customerId)  
          end
        end     
    end  
    puts riskier.length
  end

  def retrieveRiskiestCustomer(user)
    riskiest = []
    getCustomersIds(user).each do |customerId|
        customerDetails = Stripe::Customer.retrieve(customerId)
        expiryMonth = customerDetails["sources"]["data"][0]["exp_month"]
        expiryYear = customerDetails["sources"]["data"][0]["exp_year"]
        
        if expiryMonth == Date.today.month && expiryYear == Date.today.year
          if  Date.today.day >= 22
              riskiest = riskiest.push(customerId)
          end
        end     
    end
    puts riskiest.length
  end




end
