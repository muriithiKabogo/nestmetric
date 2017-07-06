class RemoveReplyFromToEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    remove_column :email_templates, :from, :string
    remove_column :email_templates, :reply, :string
    remove_column :email_templates, :name, :string
  end
end
