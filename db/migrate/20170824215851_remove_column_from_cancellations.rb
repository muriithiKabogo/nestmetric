class RemoveColumnFromCancellations < ActiveRecord::Migration[5.1]
  def change
    remove_column :cancellations, :totalCancelation, :integer
  end
end
