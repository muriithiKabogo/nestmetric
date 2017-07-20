class AddExpirymonthToRiskycustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :riskycustomers, :expiryMonth, :integer
    add_column :riskycustomers, :expiryYear, :integer
  end
end
