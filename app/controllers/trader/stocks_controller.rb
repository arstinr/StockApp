class Trader::StocksController < ApplicationController
  def index
    @stocks = current_user.stocks
    @balance = current_user.balance
  end

  def show
    @stock = current_user.stocks.find(params[:id])
  end

  def search
    @balance = current_user.balance

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
      handle_buy(symbol, price, quantity)
    elsif action_type == 'sell'
      handle_sell(symbol, price, quantity)
    else
      flash[:alert] = "Invalid action. Please try again."
    end

    redirect_to trader_stocks_path
    rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "Transaction failed: #{e.record.errors.full_messages.join(', ')}"
    redirect_to trader_stocks_path
  end

  private
  def handle_buy(symbol, price, quantity)
    price = price.to_f
    quantity = quantity.to_i

    total_price = price * quantity

    if current_user.balance >= total_price
      current_user.update(balance: current_user.balance - total_price)

      stock = current_user.stocks.find_or_initialize_by(symbol: symbol)
      stock.quantity ||= 0
      stock.quantity += quantity
      stock.save!

      current_user.transactions.create!(
        stock_id: stock.id,
        stock_name: symbol,
        stock_price: price,
        order_quantity: quantity,
        order_price: total_price,
        action_type: 'buy'
      )

      flash[:notice] = "Successfully bought #{quantity} of #{symbol}."
    else
      flash[:alert] = "Not enough balance :<<<"
    end
  end

  def handle_sell(symbol, price, quantity)
    price = price.to_f
    quantity = quantity.to_i

    stock = current_user.stocks.find_by(symbol: symbol)

    if stock.present? && stock.quantity >= quantity
      total_price = price * quantity

      stock.quantity -= quantity
      stock.save!

      #add to balance
      current_user.update(balance: current_user.balance + total_price)

      #crete transaction record
      current_user.transactions.create!(
        stock_id: stock.id,
        stock_name: symbol,
        stock_price: price,
        order_quantity: quantity,
        order_price: total_price,
        action_type: 'sell'
      )

      flash[:notice] = "Successfully sold #{quantity} of #{symbol}."
    else
      flash[:alert] = "Not enough quantity :<<<"
    end

  end

end
