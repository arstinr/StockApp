class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.integer :quantity
      t.decimal :stock_price
      t.integer :inventory
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
