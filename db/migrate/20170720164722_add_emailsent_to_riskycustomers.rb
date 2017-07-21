class AddEmailsentToRiskycustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :riskycustomers, :emailsent, :boolean
  end
end
