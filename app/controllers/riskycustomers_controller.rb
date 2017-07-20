class RiskycustomersController < ApplicationController
  before_action :authenticate_user!
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
  end

  def create

  end


end
