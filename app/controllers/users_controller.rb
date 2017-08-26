class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
    @user = current_user
    # GetRiskyCustomersJob.perform_later(@user)   

    #GetRiskyCustomersJob.perform_......later(@user)   

  	@email_template = EmailTemplate.new
  	@email_templates = @user.email_templates.all
    @allfailed  = @user.failed_charges.where("failed_at >= :startdate",{startdate: Time.now.beginning_of_month}).count
    @cancellation = @user.cancellations.where("canceled_at >= :startdate",{startdate: Time.now.beginning_of_month}).count

    @riskycustomers = @user.riskycustomers.order(:created_at).reverse
    @riskycustomers = @riskycustomers   
    @riskyRevenue = riskyTotal/100

  end

  def show
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        flash[:success]="Successfully updated profile"
        redirect_to edit_user_path
      else
        render 'edit'
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
