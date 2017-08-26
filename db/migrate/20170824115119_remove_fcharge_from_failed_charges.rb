class RemoveFchargeFromFailedCharges < ActiveRecord::Migration[5.1]
  def change
    remove_column :failed_charges, :fcharge, :integer
  end
end
