class AddActiveToEmailTemplate < ActiveRecord::Migration[5.1]
  def change
    add_column :email_templates, :active, :boolean, :default => false
  end
end
