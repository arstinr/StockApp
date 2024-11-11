class Stock < ApplicationRecord
  belongs_to :user
  has_many :transactions

  # validates :symbol, presence: true, uniqueness: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_price, numericality: { greater_than_or_equal_to: 0 }
end
