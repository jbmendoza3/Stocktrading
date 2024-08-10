class AddBalanceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :balance, :decimal, precision: 15, scale: 2, default: 100.0
  end
end
