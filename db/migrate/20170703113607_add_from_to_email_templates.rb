class AddFromToEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :email_templates, :from, :string
    add_column :email_templates, :reply, :string
    add_column :email_templates, :name, :string
  end
end
