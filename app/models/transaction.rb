class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :stock_name, presence: true
  validates :order_quantity, numericality: { greater_than: 0 }
  validates :order_price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_name, presence: true
  validates :stock_price, numericality: true
  validates :order_quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :action_type, inclusion: { in: ['buy', 'sell'] }
end
