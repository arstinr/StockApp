class Trader::StocksController < ApplicationController
  def index
    @stocks = current_user.stocks
  end

  def show
    @stock = current_user.stocks.find(params[:id])
  end

  def search
    if params[:symbol].present?
      api = AlphaVantageApi.new
      @stock_data = api.fetch_stock_data(params[:symbol])
      @stock_symbol = @stock_data['Meta Data']['2. Symbol']
      @last_open_price = @stock_data['Time Series (5min)'].values.first.dig('1. open')
    else
      flash[:alert] = "Failed to fetch stock data"
    end
  end

  def create
    symbol = params[:symbol]
    price = params[:price]
    quantity = params[:quantity]
    action_type = params[:action_type]

    if action_type == 'buy'
      handle_buy(stock_symbol, current_price, quantity)
    elsif action_type == 'sell'
      handle_sell(stock_symbol, current_price, quantity)
    else
      flash[:alert] = "Invalid action. Please try again."
    end

    redirect_to trader_stocks_path
  end

  private
  def handle_buy(symbol, price, quantity)
    total_price = price * quantity

    if current_user.balance >= total_price
      current_user.update(balance: current_user.balance - total_price)

      stock = current_user.stock.find_or_initialize_by(symbol: stock_symbol)
      stock.quantity += quantity
      stock.save!

      current_user.transactions.create!(
        stock_name: symbol,
        stock_price: price,
        order_quantity: quantity,
        order_price: total_price,
        #ADD transaction_type: 'buy'
      )
      
      flash[:notice] = "Successfully bought #{quantity} of #{stock_symbol}."
    else
      flash[:alert] = "Not enough balance :<<<"
    end
  end

  def handle_sell(symbol, price, quantity)
  end

end
