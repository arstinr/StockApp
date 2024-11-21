class RemoveStockPriceAndInventoryFromStocks < ActiveRecord::Migration[7.2]
  def change
    remove_column :stocks, :stock_price, :decimal
    remove_column :stocks, :inventory, :integer
  end
end
