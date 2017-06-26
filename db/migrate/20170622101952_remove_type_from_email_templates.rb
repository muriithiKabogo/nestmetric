class RemoveTypeFromEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    remove_column :email_templates, :type, :string
  end
end
