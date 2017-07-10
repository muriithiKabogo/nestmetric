class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protected

  def after_sign_in_path_for(resource)
  	current_user = resource
  	if current_user.uid == nil
  		user_path(current_user.id)
  	else
	   users_path
	end
	
  end
end
