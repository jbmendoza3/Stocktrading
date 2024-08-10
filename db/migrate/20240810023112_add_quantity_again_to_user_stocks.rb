class AddQuantityAgainToUserStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :user_stocks, :quantity, :integer, default: 0
  end
end
