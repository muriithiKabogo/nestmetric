class AddCustomeridToRiskycustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :riskycustomers, :customerId, :string
  end
end
