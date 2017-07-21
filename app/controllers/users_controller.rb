class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
    @user = current_user
    # GetRiskyCustomersJob.perform_later(@user)   

    #GetRiskyCustomersJob.perform_later(@user)   

  	@email_template = EmailTemplate.new
  	@email_templates = @user.email_templates.all
    @allfailed  = failed_charges_last_30_days.length
    @cancellation = all_cancellation_for_last_30_days.length

    @riskycustomers = @user.riskycustomers.order(:created_at).reverse
    @riskycustomers =@riskycustomers[0..4]
  end

  def show
  end



  def compose
  end

  def edit
    @user = current_user
  end

private

  def risky
    
  end

end
