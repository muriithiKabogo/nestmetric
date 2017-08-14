class AddRecoveredToRiskycustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :riskycustomers, :recovered, :boolean
  end
end
