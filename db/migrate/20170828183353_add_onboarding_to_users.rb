class AddOnboardingToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :onboarding, :boolean, :default => false
  end
end
