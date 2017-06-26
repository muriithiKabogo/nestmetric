class CreateEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :email_templates do |t|
      t.string :subject
      t.string :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
