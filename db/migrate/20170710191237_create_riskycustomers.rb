class CreateRiskycustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :riskycustomers do |t|
      t.string :email
      t.string :plan
      t.float :amount
      t.string :rlevel
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
