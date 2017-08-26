class AddColumnToFailedCharges < ActiveRecord::Migration[5.1]
  def change
    add_column :failed_charges, :email, :string
    add_column :failed_charges, :plan, :string
    add_column :failed_charges, :amount, :integer
    add_column :failed_charges, :failed_at, :datetime
    add_column :failed_charges, :customer_id, :string
    add_column :failed_charges, :reason, :string
    add_column :failed_charges, :attempt, :integer
  end
end
