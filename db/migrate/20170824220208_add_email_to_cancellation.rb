class AddEmailToCancellation < ActiveRecord::Migration[5.1]
  def change
    add_column :cancellations, :email, :string
    add_column :cancellations, :plan, :string
    add_column :cancellations, :amount, :integer
    add_column :cancellations, :canceled_at, :datetime
  end
end
