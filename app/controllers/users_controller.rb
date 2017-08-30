class UsersController < ApplicationController
	before_action :authenticate_user!


  def index
    @user = current_user
    # GetRiskyCustomersJob.perform_later(@user)   

    #GetRiskyCustomersJob.perform_......later(@user)   

  	@email_template = EmailTemplate.new
  	@email_templates = @user.email_templates.all

    if @user.cancellations.exists? == false 
      @cancellation = all_cancellation_for_last_30_days.length
    else
      @cancellation = @user.cancellations.where("canceled_at >= :startdate",{startdate: Time.now.beginning_of_month}).count
      # @cancellation = @user.cancellations.count
    end

    if @user.failed_charges.exists? == false
      @allfailed = failed_charges_thirty_days_ago.length
    else
      @allfailed  = @user.failed_charges.where("failed_at >= :startdate",{startdate: Time.now.beginning_of_month}).count
      # @allfailed  = @user.failed_charges.count
    end

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
    
     respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { redirect_to users_path, status: :created, location: users_path}
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end


  end

  def compose
  end

private


  def user_params
    params.require(:user).permit(:email, :picture,:onboarding)
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
