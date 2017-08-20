class CreateSents < ActiveRecord::Migration[5.1]
  def change
    create_table :sents do |t|
      t.references :user
      t.string :etype
      t.string :content
      t.string :to
      t.string :from

      t.timestamps
    end
  end
end
