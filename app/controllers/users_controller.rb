class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
    @user = current_user
    # GetRiskyCustomersJob.perform_later(@user)   

    #GetRiskyCustomersJob.perform_......later(@user)   

  	@email_template = EmailTemplate.new
  	@email_templates = @user.email_templates.all
    @allfailed  = failed_charges_last_30_days.length
    @cancellation = all_cancellation_for_last_30_days.length

    @riskycustomers = @user.riskycustomers.order(:created_at).reverse
    @riskycustomers = @riskycustomers[0..4]
    @revenatrisk = riskyTotal

  end

  def show
  end


  def edit
    @user =current_user
  end

  def update

    @user = User.find(params[:id])
    @user.picture = params[:picture]
    if @user.update(user_params)
      redirect_to user_email_templates_path
    end

  end

  def compose
  end

private


  def user_params
    params.require(:user).permit(:email, :picture)
  end

  def riskyTotal
      @user = current_user
      @riskyRevenue = @user.riskycustomers
      total = 0
      @riskyRevenue.each do |risky|
        total = total + risky.amount
      end
      total
  end

end
