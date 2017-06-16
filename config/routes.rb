Rails.application.routes.draw do

  get 'users/index'

  post 'stripe/webhook'
  root 'home#welcome'
  

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
