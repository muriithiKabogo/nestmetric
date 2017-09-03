class OmniauthCallbacksController < ApplicationController
  before_action :authenticate_user!
  def stripe_connect
    @user = current_user
    if @user.update_attributes({
      provider: request.env["omniauth.auth"].provider,
      uid: request.env["omniauth.auth"].uid,
      access_code: request.env["omniauth.auth"].credentials.token,
      publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
    })

      # anything euser_email_templates_path(current_user.id)lse you need to do in response..
      redirect_to users_path
      #set_flash_message(:notice, :success, :kind => "Stripe") if is_navigational_format?
    else
      session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

    if @user.riskycustomers.count == 0
      #@user.saveRiskyCustomers(@user)
      GetRiskyCustomersWorker.perform_in(2.minutes,@user.id)
    end
    
  end

  def failure
    
  end

end
