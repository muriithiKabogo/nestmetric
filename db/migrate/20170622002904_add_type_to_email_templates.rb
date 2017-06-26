class AddTypeToEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :email_templates, :etype, :string
  end
end
