Rails.application.routes.draw do

  get 'cancellations/index'

  get 'failed_charges/index'

  root 'home#welcome'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  
  resources :users do
    get 'email_templates/status'
  	resources :email_templates
  end
  get  'riskycustomers/customer'
  resources :riskycustomers
  resources :sendemails
  resources :cardupdates
  resources :customer_healths
 
  post 'stripe/webhook'
  post 'stripe/failed_charge'
  post 'stripe/invoice_payment_failed'
  post 'stripe/customer_source_updated'




  


  
end
