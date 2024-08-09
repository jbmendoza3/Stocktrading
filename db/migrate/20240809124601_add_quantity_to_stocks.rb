class AddQuantityToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :quantity, :integer, default: 0
  end
end
