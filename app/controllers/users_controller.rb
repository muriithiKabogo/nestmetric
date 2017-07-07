class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
  	@user = current_user
  	@email_template = EmailTemplate.new
  	@email_templates = @user.email_templates.all
  end

  def compose
  end



end
