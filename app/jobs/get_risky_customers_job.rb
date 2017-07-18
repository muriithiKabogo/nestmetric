class GetRiskyCustomersJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    # users = User.all
    # users.each do |user|
    # 	user.retrieveRiskierCustomer(user)
    # end
    
    user.saveRiskyCustomers(user)
  end

  def notDelinquentButRisky(user)
   
  end



end
