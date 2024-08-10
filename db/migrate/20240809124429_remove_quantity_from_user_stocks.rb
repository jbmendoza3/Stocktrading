class RemoveQuantityFromUserStocks < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_stocks, :quantity, :integer
  end
end
