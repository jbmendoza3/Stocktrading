class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :ticker
      t.decimal :price

      t.timestamps
    end
  end
end
