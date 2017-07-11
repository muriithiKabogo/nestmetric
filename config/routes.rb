Rails.application.routes.draw do


  get 'users/compose'
  root 'home#welcome'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  
  resources :users do
  	resources :email_templates
  end
  resources :riskycustomers
  post 'stripe/webhook'
  post 'stripe/failed_charge'
  post 'stripe/invoice_payment_failed'

  
end
