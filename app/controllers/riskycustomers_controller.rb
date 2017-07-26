class RiskycustomersController < ApplicationController

  before_action :authenticate_user!
  
  def customer

    # if Rails.env.production?
    #      Stripe.api_key = ENV['Javier_user_Secret_Key'] #@user.access_code
    #   else
    #      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    #   end

    #   token = cookies[:myToken]
    #   customer = Stripe::Customer.retrieve()
    #   customer.source = token 
    #   customer.save
    #   redirect_to root_path

  end


  def index
  	@user = current_user
    if @user.riskycustomers.count == 0
      #@user.saveRiskyCustomers(@user)
      @riskycustomers = @user.riskycustomers
      render stream: true
    else
     @riskycustomers = @user.riskycustomers
     render stream: true
    end

  end

  def new

  	@user = current_user
  	 # @user = User.find_by_uid(params[:uid])

  	 # Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  	 # @publishable_key = ENV['stripe_publishable_key'] 
  	 # @customer_email = Stripe::Customer.retrieve(params[:custId])
    #  @customer_email = @customer_email[:email]
    #  puts @customer_email.class
    
    @user = User.find_by_uid(params[:uid])


  end


end
