class AddColumnNameToTableName < ActiveRecord::Migration[7.1]
  def change
    add_column :Users, :creation_status, :string, default: 'pending'
  end
end
