class GetRiskyCustomersWorker
include Sidekiq::Worker	

	def perform(user_id)
    # Do something later
    # users = User.all
    # users.each do |user|
    # 	user.retrieveRiskierCustomer(user)
    # end
    user = User.find(user_id)
    user.saveRiskyCustomers(user)
 	 end
end