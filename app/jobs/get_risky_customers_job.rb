class GetRiskyCustomersJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    users = User.all
    users.each do |user|
    	user.retrieveRiskierCustomer(user)
    end
  end

  def notDelinquentButRisky(user)
   
  end



end
