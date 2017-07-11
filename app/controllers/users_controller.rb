class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
  	@user = current_user
  	@email_template = EmailTemplate.new
  	@email_templates = @user.email_templates.all
  end

  def show
  end

  def compose
  end

private

  def risky
    
  end

end
