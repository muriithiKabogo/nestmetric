class FailedChargesController < ApplicationController
 before_action :authenticate_user!
  def index
  	@user = current_user
  	if @user.failed_charges.exists? == false
  		# allfailed  = failed_charges_ninety_days_ago
  			allfailed = failed_charges
		allfailed.each do |failed|
			email = failed["receipt_email"]
			amount = failed["amount"]
			reason = failed["failure_message"]
			failed_at = Time.at(failed["created"])
			customer_id = failed["customer"]
			if failed["invoice"] != nil
				Stripe.api_key = @user.access_code
				invoice_object = Stripe::Invoice.retrieve(failed["invoice"])
				plan = invoice_object["lines"]["data"][0]["plan"]["name"]
				attempt = invoice_object["attempt_count"]
			else
				plan = nil
				attempt = nil
			end			
		@user.failed_charges.create(email: email,plan: plan,amount:amount, failed_at: failed_at ,customer_id: customer_id ,reason: reason, attempt: attempt)
		end
	@allfailed  = @user.failed_charges
	else
	@allfailed  = @user.failed_charges
	end
  end

end
