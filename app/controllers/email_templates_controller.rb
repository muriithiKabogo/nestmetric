class EmailTemplatesController < ApplicationController
	before_action :authenticate_user!
  
   def status
    @user = current_user
    status = cookies[:status]
    email_id = params[:emailId]
    puts status
    puts email_id
    email_template = @user.email_templates.find(email_id)
    email_template.active = status
    email_template.save
    redirect_to user_email_templates_path
   end

  def index
  	@user = current_user
    #GetRiskyCustomersJob.perform_later(@user)
  	@email_templates = @user.email_templates.all.order('id asc')
    @email_template = @user.email_templates.where(params[:id])
    
  end



  def new
  	@user = current_user
  	@email = EmailTemplate.new
  end

  def create
  	@user = current_user
    @email = @user.email_templates.create(email_params)
    redirect_to root_path
  end

    def edit
    @user = current_user
    @email_template = @user.email_templates.find(params[:id])
   end

   def update
    @user = current_user
    @email_template = @user.email_templates.find(params[:id])
    @email_template.update(email_params)
    redirect_to user_email_templates_path
   end

    def destroy
      @user = current_user
      @email_template = @user.email_templates.find(params[:id])
      @email_template.destroy
      redirect_to user_email_templates_path
   end



  private

  def email_params
  	params.require(:email_template).permit(:subject,:body,:etype)
  end

end
