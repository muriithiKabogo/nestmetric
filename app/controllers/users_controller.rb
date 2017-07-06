class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
  	@user = current_user
  	@email_template = EmailTemplate.new
  end

  def compose
  end



end
