class RiskycustomersController < ApplicationController
  
  def index
  	@user = current_user
  	@riskycustomers = @user.riskycustomers
  end

  def new
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
