class CancellationsController < ApplicationController
  before_action :authenticate_user!
  def index
  	@user = current_user
	if @user.cancellations.exists? == false
	  	# cancellations = cancellation_ninety_days_ago
	  	cancellations = get_all_cancellations
	  	cancellations.each do |cancellation|
		  	@canceled_at = Time.at(cancellation["canceled_at"])
		  	@plan = cancellation["items"]["data"][0]["plan"]["name"]
		  	@amount = cancellation["items"]["data"][0]["plan"]["amount"]
		  	Stripe.api_key = ENV['@user.access_code'] 
		  	@customer_data = Stripe::Customer.retrieve(cancellation["customer"])
		  	@email = @customer_data["email"]
		  	@user.cancellations.create(email: @email,plan: @plan,amount: @amount,canceled_at: @canceled_at)
		end
		@cancellations = @user.cancellations
	else
		@cancellations = @user.cancellations
	end
  end
end
