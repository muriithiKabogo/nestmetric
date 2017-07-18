class CreateCancellations < ActiveRecord::Migration[5.1]
  def change
    create_table :cancellations do |t|
      t.integer :totalCancelation
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
