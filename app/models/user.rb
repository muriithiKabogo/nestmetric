class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable
  has_many :email_templates ,dependent: :destroy 
  has_many :riskycustomers, dependent: :destroy 
  has_many :failed_charges, dependent: :destroy 
  has_many :cancellations, dependent: :destroy 
  has_many :sents, dependent: :destroy 

  mount_uploader :picture, PictureUploader
  validate :picture_size

 

    def send_failed_payment_email
      UserMailer.suscription_payment_failed(self).deliver_now
    end

  def stripe_subscriptions
    
    if Rails.env.production?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY_PRO']
      # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    else
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
    begin
      Stripe::Subscription.list({limit: 100},{stripe_account: uid })
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
    if Rails.env.production?
      Stripe.api_key = access_code
      # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    else
      Stripe.api_key = access_code
    end 
      customerDetails = Stripe::Customer.retrieve(customerId)
      delinquent =  customerDetails["delinquent"]

      if delinquent == false
        nonDelinquentButRiskyCustomers = nonDelinquentButRiskyCustomers.push(customerId)
      end
    end
     nonDelinquentButRiskyCustomers
  end


  def retrieveCustomer(user)
    risky = []
    riskier = []
    riskiest = []

    getCustomersIds(user).each do |customerId|
        if Rails.env.production?
          Stripe.api_key = access_code
          # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        else
          Stripe.api_key = access_code
        end 
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
    notDelinquentButRisky(user).each do |customerId|
        if Rails.env.production?
          Stripe.api_key = access_code
          # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        else
          Stripe.api_key = access_code
        end 
        customerDetails = Stripe::Customer.retrieve(customerId)
        expiryMonth = customerDetails["sources"]["data"][0]["exp_month"]
        expiryYear = customerDetails["sources"]["data"][0]["exp_year"]
        
        if expiryMonth == Date.today.month && expiryYear == Date.today.year
          if  Date.today.day  >= 1 # && Date.today.day < 15
              risky = risky.push(customerDetails)
          end
        end     
    end
    risky
  end

  def retrieveRiskierCustomer(user)
    riskier = []
    notDelinquentButRisky(user).each do |customerId|
        if Rails.env.production?
          Stripe.api_key = access_code
          # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        else
          Stripe.api_key = access_code
        end 
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
    notDelinquentButRisky(user).each do |customerId|
        if Rails.env.production?
          Stripe.api_key = access_code
          # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        else
          Stripe.api_key = access_code
        end 
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

  

  def saveRiskyCustomers(user)

    retrieveRiskyCustomer(user).each do |customer|
      planName = customer["subscriptions"]["data"][0]["items"]["data"][0]["plan"]["name"]
      amount = customer["subscriptions"]["data"][0]["items"]["data"][0]["plan"]["amount"]
      expiryMonth = customer["sources"]["data"][0]["exp_month"]
      expiryYear = customer["sources"]["data"][0]["exp_year"]
      last4 = customer["sources"]["data"][0]["last4"]
      custId = customer["id"]
      rlevel = "risky"
      riskierl = "riskier"
      riskiestl = "riskiest"

      if Date.today.day < 15

        user.riskycustomers.create(email: customer["email"],plan: planName, amount: amount, customerId: custId, rlevel: rlevel, expiryMonth: expiryMonth, expiryYear: expiryYear,last4: last4)
      
      elsif Date.today.day >= 15 && Date.today.day < 22
        
        user.riskycustomers.create(email: customer["email"],plan: planName, amount: amount, customerId: custId, rlevel: riskierl, expiryMonth: expiryMonth, expiryYear: expiryYear,last4: last4)
      
      else
        
        user.riskycustomers.create(email: customer["email"],plan: planName, amount: amount, customerId: custId, rlevel: riskiestl, expiryMonth: expiryMonth, expiryYear: expiryYear,last4: last4)
      end

    end

  end

  def stripe_charges_not_paid
    if Rails.env.production?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY_PRO']
      # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    else
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
    Stripe::Charge.list({limit: 100, paid: false},{stripe_account: uid })
  end

  def stripe_cancellation
    if Rails.env.production?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY_PRO']
      # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    else
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end
    begin
      Stripe::Subscription.list({limit: 100,status: 'canceled'},{stripe_account: uid })
    rescue Exception => e
      print e
    end
  end

   private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end


end
