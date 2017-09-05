class AddLast4ToRiskycustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :riskycustomers, :last4, :string
  end
end
