namespace :saving_risky_customer do
  desc "Save risky customers"

  task from_stripe: :environment do
  	GetRiskyCustomersJob.perform_now
  end

end
