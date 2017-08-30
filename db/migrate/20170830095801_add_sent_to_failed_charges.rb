class AddSentToFailedCharges < ActiveRecord::Migration[5.1]
  def change
    add_column :failed_charges, :sent, :boolean , :default => false
  end
end
