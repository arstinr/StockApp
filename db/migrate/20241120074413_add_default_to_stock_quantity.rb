class AddDefaultToStockQuantity < ActiveRecord::Migration[7.2]
  def change
    change_column_default :stocks, :quantity, from: nil, to: 0
    change_column_null :stocks, :quantity, false 
  end
end
